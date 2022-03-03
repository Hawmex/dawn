import 'dart:async';

import 'package:dawn/src/context.dart';
import 'package:dawn/src/debouncer.dart';
import 'package:dawn/src/widgets.dart';

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

abstract class State<T extends StatefulWidget> extends Store with Buildable {
  late final T widget;
  late final Context context;

  bool _isMounted = false;

  bool get isMounted => _isMounted;

  void initialize() {}
  void didMount() => _isMounted = true;
  void willUnmount() {}
  void dispose() => _isMounted = false;
}
