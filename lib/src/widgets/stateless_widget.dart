import 'package:dawn/foundation.dart';

import 'widget.dart';

abstract class StatelessWidget extends Widget with Buildable {
  const StatelessWidget({super.key});

  @override
  StatelessNode createNode() => StatelessNode(this);
}

class StatelessNode extends Node<StatelessWidget> {
  late Node childNode;

  StatelessNode(super.widget);

  @override
  void updateSubtree() {
    final newChildWidget = widget.build(context);

    if (newChildWidget.matches(childNode.widget)) {
      childNode.widget = newChildWidget;
    } else {
      childNode.dispose();

      childNode = newChildWidget.createNode()
        ..parentNode = this
        ..initialize();
    }
  }

  @override
  void initialize() {
    super.initialize();

    childNode = widget.build(context).createNode()
      ..parentNode = this
      ..initialize();
  }

  @override
  void dispose() {
    childNode.dispose();
    super.dispose();
  }
}
