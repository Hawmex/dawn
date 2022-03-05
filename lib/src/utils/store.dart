part of dawn;

abstract class Store {
  final _updateController = StreamController<void>.broadcast();
  final _updateDebouncer = Debouncer();

  void setState(final void Function() callback) {
    callback();
    _updateDebouncer.enqueue(() => _updateController.add(null));
  }

  StreamSubscription<void> onUpdate(final void Function() callback) =>
      _updateController.stream.listen((final event) => callback());
}
