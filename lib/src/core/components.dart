import 'dart:async';

import 'package:dawn/src/core/context.dart';

abstract class Component {
  const Component();
}

mixin Renderable on Component {
  List<Component> render(final Context context);
}

// TODO: Implement CoreComponent.

abstract class StatelessComponent extends Component with Renderable {
  const StatelessComponent() : super();
}

abstract class StatefulComponent extends Component with Renderable {
  final _updateController = StreamController<void>.broadcast();
  bool _isMounted = false;

  Stream<void> get updateStream => _updateController.stream;
  bool get isMounted => _isMounted;

  void setState(final void Function() callback) {
    callback();
    if (isMounted) didUpdate();
  }

  void initialize() {}
  void didMount() => _isMounted = true;
  void didUpdate() => _updateController.add(null);
  void willUnmount() {}
  void dispose() => _isMounted = false;
}
