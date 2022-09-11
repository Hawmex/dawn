import 'dart:html' as html;

import 'painted_widget.dart';

/// A widget that renders an [html.SpanElement].
class Text extends PaintedWidget {
  final String value;

  /// Creates a new [Text] that renders an [html.SpanElement].
  const Text(
    this.value, {
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
    super.key,
  });

  @override
  TextNode createNode() => TextNode(this);
}

class TextNode extends PaintedNode<Text, html.SpanElement> {
  TextNode(super.widget) : super(element: html.SpanElement());

  @override
  void initializeElement() {
    super.initializeElement();
    element.text = widget.value;
  }
}
