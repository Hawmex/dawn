part of dawn;

class Debouncer {
  int? _animationFrame;

  void enqueue(final void Function() task) {
    if (_animationFrame != null) {
      html.window.cancelAnimationFrame(_animationFrame!);
    }

    _animationFrame =
        html.window.requestAnimationFrame((final highResTime) => task());
  }
}
