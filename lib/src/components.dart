import 'dart:async';

import 'package:dawn/src/engine.dart';
import 'package:dawn/src/styles.dart';

abstract class Component {
  final Styles styles;

  const Component({
    final Styles? styles,
  }) : styles = styles ?? const Styles([]);
}

mixin Renderable {
  List<Component> render(final Context context);
}

abstract class StatelessComponent extends Component with Renderable {
  const StatelessComponent() : super();
}

abstract class StatefulComponent extends Component {
  const StatefulComponent() : super();

  State<StatefulComponent> createState();
}

abstract class State<T extends StatefulComponent> with Renderable {
  late final T component;
  late final Context context;

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

class Text extends Component {
  final String value;

  const Text(this.value, {final Styles? styles}) : super(styles: styles);
}

class Container extends Component with Renderable {
  final List<Component> children;

  const Container(
    this.children, {
    final Styles? styles,
  }) : super(styles: styles);

  @override
  List<Component> render(final Context context) => children;
}
