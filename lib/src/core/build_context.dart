import 'package:dawn/widgets.dart';

class BuildContext {
  final Node _node;

  const BuildContext(this._node);

  T dependOnInheritedWidgetOfExactType<T extends InheritedWidget>() =>
      _node.dependOnInheritedWidgetOfExactType<T>();
}
