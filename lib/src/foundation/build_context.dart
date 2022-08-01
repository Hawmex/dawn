import 'package:dawn/widgets.dart';

import 'node.dart';

class BuildContext {
  final Node _node;

  const BuildContext(this._node);

  Widget get widget => _node.widget;

  T dependOnInheritedWidgetOfExactType<T extends InheritedWidget>() =>
      _node.dependOnInheritedWidgetOfExactType<T>();
}
