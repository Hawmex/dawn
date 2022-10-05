import 'dart:async';

/// A store that can notify its listeners when [setState] is called.
abstract class Store {
  bool _isActive = false;
  late final StreamController<void> _updateController;

  /// Notifies the listeners.
  void setState(final void Function() callback) {
    callback();
    if (_isActive) _updateController.add(null);
  }

  /// Listens to this [Store] for notifications.
  StreamSubscription<void> listen(final void Function() onUpdate) =>
      _updateController.stream.listen((final event) => onUpdate());

  /// Initializes this [Store].
  void initialize() {
    _isActive = true;
    _updateController = StreamController.broadcast();
  }

  /// Disposes this [Store].
  void dispose() {
    _updateController.close();
    _isActive = false;
  }
}
