import 'dart:html' as html;

class Debouncer {
  int? _animationFrame;

  void enqueueTask(final void Function() task) {
    if (_animationFrame != null) {
      html.window.cancelAnimationFrame(_animationFrame!);
    }

    _animationFrame = html.window.requestAnimationFrame(
      (final highResTime) => task(),
    );
  }
}
