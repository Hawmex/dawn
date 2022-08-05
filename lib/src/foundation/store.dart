import 'dart:async';

abstract class Store {
  bool _isActive = false;
  late final StreamController<void> _updateController;

  void setState(final void Function() callback) {
    callback();
    if (_isActive) _updateController.add(null);
  }

  StreamSubscription<void> listen(final void Function() onUpdate) =>
      _updateController.stream.listen((final event) => onUpdate());

  void initialize() {
    _isActive = true;
    _updateController = StreamController.broadcast();
  }

  void dispose() {
    _updateController.close();
    _isActive = false;
  }
}
