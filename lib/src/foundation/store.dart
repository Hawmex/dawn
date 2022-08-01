import 'dart:async';

abstract class Store {
  late final StreamController<void> _updateController;

  void setState(final void Function() callback) {
    callback();
    _updateController.add(null);
  }

  StreamSubscription<void> listen(final void Function() onUpdate) =>
      _updateController.stream.listen((final event) => onUpdate());

  void initialize() => _updateController = StreamController.broadcast();
  void dispose() => _updateController.close();
}
