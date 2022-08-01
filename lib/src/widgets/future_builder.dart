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
  Object? _activeCallbackIdentity;
  late AsyncSnapshot<T> _snapshot;

  void _subscribe() {
    if (widget.future != null) {
      final callbackIdentity = Object();

      _activeCallbackIdentity = callbackIdentity;

      widget.future!.then<void>(
        (final T data) {
          if (_activeCallbackIdentity == callbackIdentity) {
            setState(() {
              _snapshot = AsyncSnapshot.withData(
                connectionState: ConnectionState.done,
                data: data,
              );
            });
          }
        },
        onError: (final Object error, final StackTrace stackTrace) {
          if (_activeCallbackIdentity == callbackIdentity) {
            setState(() {
              _snapshot = AsyncSnapshot.withError(
                connectionState: ConnectionState.done,
                error: error,
                stackTrace: stackTrace,
              );
            });
          }
        },
      );

      _snapshot = _snapshot.inConnectionState(ConnectionState.waiting);
    }
  }

  void _unsubscribe() => _activeCallbackIdentity = null;

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
  void didWidgetUpdate(final FutureBuilder<T> oldWidget) {
    super.didWidgetUpdate(oldWidget);

    if (widget.future != oldWidget.future) {
      if (_activeCallbackIdentity != null) {
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
