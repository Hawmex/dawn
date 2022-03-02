import 'dart:async';

import 'package:dawn/src/context.dart';
import 'package:dawn/src/debouncer.dart';
import 'package:dawn/src/widgets.dart';

abstract class Store {
  final _updateController = StreamController<void>.broadcast();
  final _updateDebouncer = Debouncer();

  void setState(final void Function() callback) {
    callback();
    _updateDebouncer.enqueue(didUpdate);
  }

  StreamSubscription<void> listen(final void Function() onData) =>
      _updateController.stream.listen((final event) => onData());

  void didUpdate() => _updateController.add(null);
}

abstract class State<T extends StatefulWidget> with Buildable implements Store {
  late final T widget;
  late final Context context;

  bool _isMounted = false;

  bool get isMounted => _isMounted;

  @override
  void setState(final void Function() callback) {
    callback();

    _updateDebouncer.enqueue(() {
      if (isMounted) didUpdate();
    });
  }

  void initialize() {}
  void didMount() => _isMounted = true;
  void willUnmount() {}
  void dispose() => _isMounted = false;
}
