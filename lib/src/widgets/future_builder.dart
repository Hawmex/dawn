import 'package:dawn/foundation.dart';

import 'stateful_widget.dart';
import 'widget.dart';

class FutureBuilder<T> extends StatefulWidget {
  final AsyncWidgetBuilder<T> builder;
  final Future<T>? future;
  final T? initialData;

  const FutureBuilder(this.builder, {this.future, this.initialData, super.key});

  @override
  State createState() => _FutureBuilderState<T>();
}

class _FutureBuilderState<T> extends State<FutureBuilder<T>> {
  Object? activeCallbackIdentity;
  late AsyncSnapshot<T> snapshot;

  void subscribe() {
    if (widget.future != null) {
      final callbackIdentity = Object();

      activeCallbackIdentity = callbackIdentity;

      widget.future!.then<void>(
        (final T data) {
          if (activeCallbackIdentity == callbackIdentity) {
            setState(() {
              snapshot = AsyncSnapshot.withData(
                connectionState: ConnectionState.done,
                data: data,
              );
            });
          }
        },
        onError: (final Object error, final StackTrace stackTrace) {
          if (activeCallbackIdentity == callbackIdentity) {
            setState(() {
              snapshot = AsyncSnapshot.withError(
                connectionState: ConnectionState.done,
                error: error,
                stackTrace: stackTrace,
              );
            });
          }
        },
      );

      snapshot = snapshot.inConnectionState(ConnectionState.waiting);
    }
  }

  void unsubscribe() => activeCallbackIdentity = null;

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
  void didWidgetUpdate(final FutureBuilder<T> oldWidget) {
    super.didWidgetUpdate(oldWidget);

    if (widget.future != oldWidget.future) {
      if (activeCallbackIdentity != null) {
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
