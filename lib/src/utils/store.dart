import 'dart:async';

import 'package:dawn/src/utils/debouncer.dart';

/// A base class for storing data and subscribing to it.
///
/// It can be used to implement complex state management solutions in patterns
/// similar to `Provider`.
abstract class Store {
  final _updateController = StreamController<void>.broadcast();
  final _updateDebouncer = Debouncer();

  /// Runs the [callback] and debounces a call to [onUpdate].
  void setState(final void Function() callback) {
    callback();
    _updateDebouncer.enqueueTask(() => _updateController.add(null));
  }

  /// [callback] is called after [setState] has been called.
  StreamSubscription<void> onUpdate(final void Function() callback) =>
      _updateController.stream.listen((final event) => callback());
}
