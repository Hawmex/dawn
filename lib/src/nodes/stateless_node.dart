import 'package:dawn/src/node_creator.dart';
import 'package:dawn/src/nodes/node.dart';
import 'package:dawn/src/widgets/stateless_widget.dart';

class StatelessNode extends Node<StatelessWidget> {
  late Node childNode;

  StatelessNode({required super.widget, super.parentNode});

  @override
  void initialize() {
    super.initialize();

    childNode = createNode(widget: widget.build(context), parentNode: this)
      ..initialize();
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

      childNode = createNode(widget: newChildWidget, parentNode: this)
        ..initialize();
    }
  }

  @override
  void dispose() {
    childNode.dispose();
    super.dispose();
  }
}
