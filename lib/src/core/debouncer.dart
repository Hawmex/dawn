import 'dart:html' as html;

/// Debounces multiple tasks by running only the last one using JavaScript's
/// `requestAnimationFrame` API.
class Debouncer {
  int? _animationFrameId;

  /// Adds the given [task] to the queue.
  void enqueueTask(final void Function() task) {
    if (_animationFrameId != null) {
      html.window.cancelAnimationFrame(_animationFrameId!);
    }

    _animationFrameId =
        html.window.requestAnimationFrame((final highResTime) => task());
  }
}
