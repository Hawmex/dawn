import 'dart:html' as html;

import 'painted_widget.dart';
import 'widget.dart';

/// A [Widget] that paints an [html.DivElement].
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

/// A [Node] corresponding to [Container].
class ContainerNode extends MultiChildPaintedNode<Container, html.DivElement> {
  /// Creates a new instance of [ContainerNode].
  ContainerNode(super.widget) : super(element: html.DivElement());

  @override
  List<Widget> get childWidgets => widget.children;

  @override
  void initializeElement() {
    super.initializeElement();
    addEventSubscription('scroll', widget.onScroll);
  }
}
