/// The connection state of an [AsyncSnapshot].
enum ConnectionState { none, waiting, active, done }

/// An immutable representation of the most recent interaction with an
/// asynchronous computation.
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
  });

  factory AsyncSnapshot.nothing() =>
      const AsyncSnapshot._(connectionState: ConnectionState.none);

  factory AsyncSnapshot.waiting() =>
      const AsyncSnapshot._(connectionState: ConnectionState.waiting);

  factory AsyncSnapshot.withData({
    required final ConnectionState connectionState,
    required final T data,
  }) =>
      AsyncSnapshot._(connectionState: connectionState, data: data);

  factory AsyncSnapshot.withError({
    required final ConnectionState connectionState,
    required final Object error,
    final StackTrace stackTrace = StackTrace.empty,
  }) =>
      AsyncSnapshot._(
        connectionState: connectionState,
        error: error,
        stackTrace: stackTrace,
      );

  bool get hasData => data != null;
  bool get hasError => error != null;

  /// Returns the [data]. An error is thrown if [data] is `null`.
  T get requireData {
    if (hasData) return data!;
    if (hasError) Error.throwWithStackTrace(error!, stackTrace!);
    throw StateError('Snapshot has neither data nor error.');
  }

  /// Returns a copy of the current [AsyncSnapshot] with the given
  /// [connectionState].
  AsyncSnapshot<T> inConnectionState(final ConnectionState connectionState) =>
      AsyncSnapshot._(
        connectionState: connectionState,
        data: data,
        error: error,
        stackTrace: stackTrace,
      );
}
