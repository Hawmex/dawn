import 'package:dawn/src/node_creator.dart';
import 'package:dawn/src/widgets.dart';

import 'node.dart';

class StatelessNode extends Node<StatelessWidget> {
  late Node childNode;

  StatelessNode(
    final StatelessWidget widget, {
    final Node? parentNode,
  }) : super(widget, parentNode: parentNode);

  @override
  void initialize() {
    super.initialize();

    childNode = createNode(
      widget.build(context),
      parentNode: this,
    )..initialize();
  }

  @override
  void didWidgetUpdate(final StatelessWidget oldWidget) {
    super.didWidgetUpdate(oldWidget);

    final newChildWidget = widget.build(context);

    if (childNode.widget.runtimeType == newChildWidget.runtimeType &&
        childNode.widget.key == newChildWidget.key) {
      childNode.widget = newChildWidget;
    } else {
      childNode.dispose();
      childNode = createNode(newChildWidget, parentNode: this);
    }
  }

  @override
  void dispose() {
    childNode.dispose();
    super.dispose();
  }
}
