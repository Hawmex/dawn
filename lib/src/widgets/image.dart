import 'dart:html' as html;

import 'package:dawn/foundation.dart';

import 'painted_widget.dart';

/// A widget that renders an [html.ImageElement].
class Image extends PaintedWidget {
  final String source;
  final String? alternativeText;

  final EventListener<html.ErrorEvent>? onError;

  /// Creates a new [Image] that renders an [html.ImageElement].
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

class ImageNode extends PaintedNode<Image, html.ImageElement> {
  ImageNode(super.widget) : super(element: html.ImageElement());

  @override
  void initializeElement() {
    super.initializeElement();

    element
      ..on['error'].cast<html.ErrorEvent>().listen(widget.onError)
      ..src = widget.source
      ..alt = widget.alternativeText ?? '';
  }
}
