import 'dart:html' as html;

import 'package:dawn/foundation.dart';

import 'painted_widget.dart';
import 'widget.dart';

/// A widget that can have multiple children and renders an [html.DivElement].
///
/// **Notice:** [Container] and [ContainerNode] are deeply used by Dawn's
/// engine. [ContainerNode] is and should be the only [Node] that can have
/// multiple child nodes. Thus, developers should not extend or modify
/// [Container] or [ContainerNode]. They shouldn't create their own containers
/// either.
class Container extends PaintedWidget {
  final List<Widget> children;

  final EventListener? onScroll;

  /// Creates a new [Container] that can have multiple children and renders an
  /// [html.DivElement].
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

    childNodes =
        widget.children.map((final child) => child.createNode()).toList();

    for (final childNode in childNodes) {
      childNode
        ..parentNode = this
        ..initialize();
    }
  }

  @override
  void initializeElement() {
    super.initializeElement();
    element.addListener('scroll', widget.onScroll);
  }

  @override
  void disposeElement() {
    element.removeListener('scroll', widget.onScroll);
    super.disposeElement();
  }

  @override
  void didWidgetUpdate(final Container oldWidget) {
    super.didWidgetUpdate(oldWidget);

    final oldChildNodes = childNodes;

    final newChildNodes =
        widget.children.map((final child) => child.createNode()).toList();

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
      if (!oldChildNodes.contains(childNode)) {
        childNode
          ..parentNode = this
          ..initialize();
      }
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
