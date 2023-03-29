import 'dart:html' as html;

import 'package:dawn/core.dart';

import 'painted_widget.dart';
import 'widget.dart';

/// A [Widget] that paints an [html.ImageElement].
class Image extends PaintedWidget {
  final String source;
  final String? alternativeText;

  final EventCallback? onError;

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
    super.key,
    super.ref,
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

    addEventSubscription(
      type: 'error',
      callback: widget.onError,
      eventTransformer: (final html.Event event) =>
          EventDetails(event, targetNode: this),
    );

    element
      ..src = widget.source
      ..alt = widget.alternativeText ?? '';
  }
}
