import 'dart:html' as html;

import 'painted_widget.dart';

class Image extends PaintedWidget {
  final String source;
  final String? alternativeText;

  final EventSubscriptionCallback<html.ErrorEvent>? onError;

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

class ImageNode extends ChildlessPaintedNode<Image, html.ImageElement> {
  ImageNode(super.widget) : super(element: html.ImageElement());

  @override
  void initializeElement() {
    super.initializeElement();

    addEventSubscription(
      target: element,
      type: 'error',
      callback: widget.onError,
    );

    element
      ..src = widget.source
      ..alt = widget.alternativeText ?? '';
  }
}
