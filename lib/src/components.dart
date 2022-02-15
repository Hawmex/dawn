import 'dart:async';

import 'package:dawn/src/engine.dart';

abstract class Component {
  final String styles;

  const Component({this.styles = ''});
}

mixin Renderable {
  List<Component> render(final Context context);
}

abstract class StatelessComponent extends Component with Renderable {
  const StatelessComponent({final String styles = ''}) : super(styles: styles);
}

abstract class StatefulComponent extends Component {
  const StatefulComponent({final String styles = ''}) : super(styles: styles);

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

  const Text(this.value, {final String styles = ''}) : super(styles: styles);
}
