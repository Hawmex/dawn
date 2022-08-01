import 'dart:html' as html;

class Debouncer {
  int? _animationFrameId;

  void enqueueTask(final void Function() task) {
    if (_animationFrameId != null) {
      html.window.cancelAnimationFrame(_animationFrameId!);
    }

    _animationFrameId = html.window.requestAnimationFrame(
      (final highResTime) => task(),
    );
  }
}
