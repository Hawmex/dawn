import 'dart:html' as html;

/// Each instance handles multiple calls to a heavy task and executes only the
/// last one.
class Debouncer {
  int? _animationFrameId;

  /// Adds a new heavy task to the queue.
  void enqueueTask(final void Function() task) {
    if (_animationFrameId != null) {
      html.window.cancelAnimationFrame(_animationFrameId!);
    }

    _animationFrameId =
        html.window.requestAnimationFrame((final highResTime) => task());
  }
}
