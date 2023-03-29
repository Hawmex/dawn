import 'dart:html' as html;

import 'package:dawn/core.dart';

import 'painted_widget.dart';
import 'widget.dart';

/// A [Widget] that paints an [html.DivElement].
class Container extends PaintedWidget {
  final List<Widget> children;

  final EventCallback? onScroll;

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
    this.onScroll,
    super.key,
    super.ref,
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

    addEventSubscription(
      type: 'scroll',
      callback: widget.onScroll,
      eventTransformer: (final html.Event event) =>
          EventDetails(event, targetNode: this),
    );
  }
}
