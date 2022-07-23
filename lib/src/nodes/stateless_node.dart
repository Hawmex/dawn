import 'package:dawn/widgets.dart';

import 'node.dart';

class StatelessNode extends Node<StatelessWidget> {
  late Node childNode;

  StatelessNode({required super.widget, super.parentNode});

  @override
  void initialize() {
    super.initialize();

    childNode = Node.create(
      widget: widget.build(context),
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

      childNode = Node.create(
        widget: newChildWidget,
        parentNode: this,
      )..initialize();
    }
  }

  @override
  void dispose() {
    childNode.dispose();
    super.dispose();
  }
}
