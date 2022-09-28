import 'dart:html' as html;

import 'painted_widget.dart';
import 'widget.dart';

class Container extends PaintedWidget {
  final List<Widget> children;

  final EventSubscriptionCallback? onScroll;

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

class ContainerNode extends MultiChildPaintedNode<Container, html.DivElement> {
  ContainerNode(super.widget) : super(element: html.DivElement());

  @override
  List<Widget> get newChildWidgets => widget.children;

  @override
  void initializeElement() {
    super.initializeElement();

    addEventSubscription(
      target: element,
      type: 'scroll',
      callback: widget.onScroll,
    );
  }
}
