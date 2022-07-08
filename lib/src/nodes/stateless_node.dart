import 'package:dawn/src/node_creator.dart';
import 'package:dawn/src/nodes.dart';
import 'package:dawn/src/widgets.dart';

class StatelessNode extends Node<StatelessWidget> {
  late Node childNode;

  StatelessNode(super.widget, {super.parentNode});

  @override
  void initialize() {
    super.initialize();

    childNode = createNode(widget.build(context), parentNode: this)
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
      childNode = createNode(newChildWidget, parentNode: this)..initialize();
    }
  }

  @override
  void dispose() {
    childNode.dispose();
    super.dispose();
  }
}
