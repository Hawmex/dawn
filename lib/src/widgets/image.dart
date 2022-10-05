import 'dart:html' as html;

import 'painted_widget.dart';
import 'widget.dart';

/// A [Widget] that paints an [html.ImageElement].
class Image extends PaintedWidget {
  final String source;
  final String? alternativeText;

  final EventSubscriptionCallback<html.ErrorEvent>? onError;

  /// Creates a new instance of [Image].
  const Image(
    this.source, {
    this.alternativeText,
    this.onError,
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
  ImageNode createNode() => ImageNode(this);
}

/// A [Node] corresponding to [Image].
class ImageNode extends ChildlessPaintedNode<Image, html.ImageElement> {
  /// Creates a new instance of [ImageNode].
  ImageNode(super.widget) : super(element: html.ImageElement());

  @override
  void initializeElement() {
    super.initializeElement();

    addEventSubscription('error', widget.onError);

    element
      ..src = widget.source
      ..alt = widget.alternativeText ?? '';
  }
}
