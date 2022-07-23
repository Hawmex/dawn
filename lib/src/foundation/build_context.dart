import 'package:dawn/widgets.dart';

import '../nodes/node.dart';

class BuildContext {
  final Node _node;

  const BuildContext({required final Node node}) : _node = node;

  List<Widget> get parentWidgets =>
      _node.parentNodes.map((final parentNode) => parentNode.widget).toList();

  T getParentWidgetOfExactType<T extends Widget>() {
    return parentWidgets.firstWhere(
      (final parentWidget) => parentWidget.runtimeType == T,
    ) as T;
  }
}
