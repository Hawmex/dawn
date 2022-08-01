enum ConnectionState { none, waiting, active, done }

class AsyncSnapshot<T> {
  final ConnectionState connectionState;
  final T? data;
  final Object? error;
  final StackTrace? stackTrace;

  const AsyncSnapshot._({
    required this.connectionState,
    this.data,
    this.error,
    this.stackTrace,
  })  : assert(data == null || error == null),
        assert(stackTrace == null || error != null);

  factory AsyncSnapshot.nothing() {
    return const AsyncSnapshot._(connectionState: ConnectionState.none);
  }

  factory AsyncSnapshot.waiting() {
    return const AsyncSnapshot._(connectionState: ConnectionState.waiting);
  }

  factory AsyncSnapshot.withData({
    required final ConnectionState connectionState,
    required final T data,
  }) {
    return AsyncSnapshot._(connectionState: connectionState, data: data);
  }

  factory AsyncSnapshot.withError({
    required final ConnectionState connectionState,
    required final Object error,
    final StackTrace stackTrace = StackTrace.empty,
  }) {
    return AsyncSnapshot._(
      connectionState: connectionState,
      error: error,
      stackTrace: stackTrace,
    );
  }

  bool get hasData => data != null;
  bool get hasError => error != null;

  T get requireData {
    if (hasData) return data!;
    if (hasError) Error.throwWithStackTrace(error!, stackTrace!);
    throw StateError('Snapshot has neither data nor error.');
  }

  AsyncSnapshot<T> inConnectionState(final ConnectionState connectionState) {
    return AsyncSnapshot._(
      connectionState: connectionState,
      data: data,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
