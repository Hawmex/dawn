import 'dart:html' as html;

import 'package:dawn/foundation.dart';

import 'painted_widget.dart';
import 'widget.dart';

class Container extends PaintedWidget {
  final List<Widget> children;

  final EventListener? onScroll;

  const Container(
    this.children, {
    super.style,
    super.animation,
    super.onTap,
    super.onPointerDown,
    super.onPointerUp,
    super.onPointerEnter,
    super.onPointerLeave,
    super.onPointerMove,
    super.onPointerCancel,
    super.onPointerOver,
    super.onPointerOut,
    super.onMouseDown,
    super.onMouseUp,
    super.onMouseEnter,
    super.onMouseLeave,
    super.onMouseMove,
    super.onMouseOver,
    super.onMouseOut,
    super.onTouchStart,
    super.onTouchEnd,
    super.onTouchMove,
    super.onTouchCancel,
    this.onScroll,
    super.key,
  });

  @override
  ContainerNode createNode() => ContainerNode(this);
}

class ContainerNode extends PaintedNode<Container, html.DivElement> {
  late List<Node> childNodes;

  ContainerNode(super.widget) : super(element: html.DivElement());

  @override
  void initialize() {
    super.initialize();

    childNodes = widget.children
        .map((final child) => child.createNode()..parentNode = this)
        .toList();

    for (final childNode in childNodes) {
      childNode.initialize();
    }
  }

  @override
  void initializeElement() {
    super.initializeElement();
    element.addEventListener('scroll', widget.onScroll);
  }

  @override
  void disposeElement() {
    element.removeEventListener('scroll', widget.onScroll);
    super.disposeElement();
  }

  @override
  void didWidgetUpdate(final Container oldWidget) {
    super.didWidgetUpdate(oldWidget);

    final oldChildNodes = childNodes;

    final newChildNodes = widget.children
        .map((final child) => child.createNode()..parentNode = this)
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
              newChildNode.widget.matches(oldChildNode.widget),
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
