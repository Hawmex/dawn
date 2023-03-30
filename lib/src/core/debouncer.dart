import 'dart:async';

/// Debounces multiple tasks by running only the last one using
/// [scheduleMicrotask].
class Debouncer {
  Object? _latestTaskIdentity;

  /// Adds the given [task] to the queue.
  void enqueueTask(final void Function() task) {
    final currentTaskIdentity = Object();

    _latestTaskIdentity = currentTaskIdentity;

    scheduleMicrotask(() {
      if (_latestTaskIdentity == currentTaskIdentity) task();
    });
  }
}
