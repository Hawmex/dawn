import 'dart:html' as html;

import 'package:dawn/src/node_creator.dart';
import 'package:dawn/src/nodes/framework_node.dart';
import 'package:dawn/src/nodes/node.dart';
import 'package:dawn/src/widgets/container.dart';

class ContainerNode extends FrameworkNode<Container, html.DivElement> {
  late List<Node> childNodes;

  ContainerNode({required super.widget, super.parentNode})
      : super(element: html.DivElement());

  @override
  void initialize() {
    super.initialize();

    childNodes = widget.children
        .map((final child) => createNode(widget: child, parentNode: this))
        .toList();

    for (final childNode in childNodes) {
      childNode.initialize();
    }
  }

  @override
  void didWidgetUpdate(final Container oldWidget) {
    super.didWidgetUpdate(oldWidget);

    final oldChildNodes = childNodes;

    final newChildNodes = widget.children
        .map((final child) => createNode(widget: child, parentNode: this))
        .toList();

    int exactSearchStartIndex = 0;
    int sameTypeSearchStartIndex = 0;

    for (final oldChildNode in oldChildNodes) {
      final index = newChildNodes.indexWhere(
        (final newChildNode) => newChildNode.widget == oldChildNode.widget,
        exactSearchStartIndex,
      );

      if (index > -1) {
        newChildNodes[index] = oldChildNode;
        exactSearchStartIndex = index + 1;
      }
    }

    for (final oldChildNode in oldChildNodes) {
      if (!newChildNodes.contains(oldChildNode)) {
        final index = newChildNodes.indexWhere(
          (final newChildNode) =>
              !oldChildNodes.contains(newChildNode) &&
              newChildNode.widget.runtimeType ==
                  oldChildNode.widget.runtimeType &&
              newChildNode.widget.key == oldChildNode.widget.key,
          sameTypeSearchStartIndex,
        );

        if (index > -1) {
          final newChildNode = newChildNodes[index];

          oldChildNode.widget = newChildNode.widget;
          newChildNodes[index] = oldChildNode;
          sameTypeSearchStartIndex = index + 1;
        }
      }
    }

    for (final childNode in childNodes) {
      if (!newChildNodes.contains(childNode)) childNode.dispose();
    }

    childNodes = newChildNodes;

    for (final childNode in childNodes) {
      if (!oldChildNodes.contains(childNode)) childNode.initialize();
    }
  }

  @override
  void dispose() {
    for (final childNode in childNodes) {
      childNode.dispose();
    }

    super.dispose();
  }
}
