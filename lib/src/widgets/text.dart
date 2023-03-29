import 'dart:html' as html;

import 'painted_widget.dart';
import 'widget.dart';

/// A [Widget] that paints an [html.SpanElement].
class Text extends PaintedWidget {
  final String value;

  /// Creates a new instance of [Text].
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
    super.key,
    super.ref,
  });

  @override
  TextNode createNode() => TextNode(this);
}

/// A [Node] corresponding to [Text].
class TextNode extends ChildlessPaintedNode<Text, html.SpanElement> {
  /// Creates a new instance of [TextNode].
  TextNode(super.widget) : super(element: html.SpanElement());

  @override
  void initializeElement() {
    super.initializeElement();
    element.text = widget.value;
  }
}
