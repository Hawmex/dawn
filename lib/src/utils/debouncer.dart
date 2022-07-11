import 'dart:html' as html;

/// A class to debounce heavy tasks like rebuilding Dawn widgets.
///
/// [Debouncer] uses `requestAnimationFrame` API under the hood.
class Debouncer {
  int? _animationFrame;

  /// Add a new task to the execution queue.
  ///
  /// ```dart
  /// Debouncer()
  ///   ..enqueueTask(() => print('Hello World!'))
  ///   ..enqueueTask(() => print('Hello World!'));
  /// ```
  ///
  /// `Hello World!` will be printed once.
  void enqueueTask(final void Function() task) {
    if (_animationFrame != null) {
      html.window.cancelAnimationFrame(_animationFrame!);
    }

    _animationFrame =
        html.window.requestAnimationFrame((final highResTime) => task());
  }
}
