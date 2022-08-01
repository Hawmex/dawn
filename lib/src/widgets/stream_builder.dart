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
  StreamSubscription<T>? _subscription;
  late AsyncSnapshot<T> _snapshot;

  void _subscribe() {
    if (widget.stream != null) {
      _subscription = widget.stream!.listen(
        (final T data) {
          setState(() {
            _snapshot = AsyncSnapshot.withData(
              connectionState: ConnectionState.active,
              data: data,
            );
          });
        },
        onError: (final Object error, final StackTrace stackTrace) {
          setState(() {
            _snapshot = AsyncSnapshot.withError(
              connectionState: ConnectionState.active,
              error: error,
              stackTrace: stackTrace,
            );
          });
        },
        onDone: () {
          setState(() {
            _snapshot = _snapshot.inConnectionState(ConnectionState.done);
          });
        },
      );

      _snapshot = _snapshot.inConnectionState(ConnectionState.waiting);
    }
  }

  void _unsubscribe() {
    if (_subscription != null) {
      _subscription!.cancel();
      _subscription = null;
    }
  }

  @override
  void initialize() {
    super.initialize();

    _snapshot = widget.initialData == null
        ? AsyncSnapshot.nothing()
        : AsyncSnapshot.withData(
            connectionState: ConnectionState.none,
            data: widget.initialData as T,
          );

    _subscribe();
  }

  @override
  void didWidgetUpdate(final StreamBuilder<T> oldWidget) {
    super.didWidgetUpdate(oldWidget);

    if (widget.stream != oldWidget.stream) {
      if (_subscription != null) {
        _unsubscribe();
        _snapshot = _snapshot.inConnectionState(ConnectionState.none);
      }

      _subscribe();
    }
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) =>
      widget.builder(context, _snapshot);
}
