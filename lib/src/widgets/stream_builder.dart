import 'dart:async';

import 'package:dawn/foundation.dart';

import 'stateful_widget.dart';
import 'widget.dart';

class StreamBuilder<T> extends StatefulWidget {
  final AsyncWidgetBuilder<T> builder;
  final Stream<T>? stream;
  final T? initialData;

  const StreamBuilder(this.builder, {this.stream, this.initialData, super.key});

  @override
  State createState() => _StreamBuilderState<T>();
}

class _StreamBuilderState<T> extends State<StreamBuilder<T>> {
  StreamSubscription<T>? subscription;
  late AsyncSnapshot<T> snapshot;

  void subscribe() {
    if (widget.stream != null) {
      subscription = widget.stream!.listen(
        (final T data) {
          setState(() {
            snapshot = AsyncSnapshot.withData(
              connectionState: ConnectionState.active,
              data: data,
            );
          });
        },
        onError: (final Object error, final StackTrace stackTrace) {
          setState(() {
            snapshot = AsyncSnapshot.withError(
              connectionState: ConnectionState.active,
              error: error,
              stackTrace: stackTrace,
            );
          });
        },
        onDone: () {
          setState(() {
            snapshot = snapshot.inConnectionState(ConnectionState.done);
          });
        },
      );

      snapshot = snapshot.inConnectionState(ConnectionState.waiting);
    }
  }

  void unsubscribe() {
    if (subscription != null) {
      subscription!.cancel();
      subscription = null;
    }
  }

  @override
  void initialize() {
    super.initialize();

    snapshot = widget.initialData == null
        ? AsyncSnapshot.nothing()
        : AsyncSnapshot.withData(
            connectionState: ConnectionState.none,
            data: widget.initialData as T,
          );

    subscribe();
  }

  @override
  void didWidgetUpdate(final StreamBuilder<T> oldWidget) {
    super.didWidgetUpdate(oldWidget);

    if (widget.stream != oldWidget.stream) {
      if (subscription != null) {
        unsubscribe();

        snapshot = snapshot.inConnectionState(ConnectionState.none);
      }

      subscribe();
    }
  }

  @override
  void dispose() {
    unsubscribe();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => widget.builder(context, snapshot);
}
