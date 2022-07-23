import 'dart:async';

import 'debouncer.dart';

abstract class Store {
  final _updateStreamDebouncer = Debouncer();

  late final StreamController<void> _updateStreamController;
  late final StreamSubscription<void> _updateStreamSubscription;

  StreamSubscription<void> onUpdate(final void Function() callback) =>
      _updateStreamController.stream.listen((final event) => callback());

  void setState(final void Function() callback) {
    _updateStreamDebouncer.enqueueTask(() => _updateStreamController.add(null));
  }

  void initialize() {
    _updateStreamController = StreamController<void>.broadcast();
    _updateStreamSubscription = onUpdate(didUpdate);
  }

  void didUpdate() {}

  void dispose() {
    _updateStreamSubscription.cancel();
    _updateStreamController.close();
  }
}
