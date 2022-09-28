import 'dart:html' as html;

import 'package:dawn/animation.dart';
import 'package:dawn/core.dart';

import 'widget.dart';

abstract class PaintedWidget extends Widget {
  final Style? style;
  final Animation? animation;

  final EventListener<html.MouseEvent>? onTap;

  final EventListener<html.PointerEvent>? onPointerDown;
  final EventListener<html.PointerEvent>? onPointerUp;
  final EventListener<html.PointerEvent>? onPointerEnter;
  final EventListener<html.PointerEvent>? onPointerLeave;
  final EventListener<html.PointerEvent>? onPointerMove;
  final EventListener<html.PointerEvent>? onPointerCancel;
  final EventListener<html.PointerEvent>? onPointerOver;
  final EventListener<html.PointerEvent>? onPointerOut;

  final EventListener<html.MouseEvent>? onMouseDown;
  final EventListener<html.MouseEvent>? onMouseUp;
  final EventListener<html.MouseEvent>? onMouseEnter;
  final EventListener<html.MouseEvent>? onMouseLeave;
  final EventListener<html.MouseEvent>? onMouseMove;
  final EventListener<html.MouseEvent>? onMouseOver;
  final EventListener<html.MouseEvent>? onMouseOut;

  final EventListener<html.TouchEvent>? onTouchStart;
  final EventListener<html.TouchEvent>? onTouchEnd;
  final EventListener<html.TouchEvent>? onTouchMove;
  final EventListener<html.TouchEvent>? onTouchCancel;

  const PaintedWidget({
    this.style,
    this.animation,
    this.onTap,
    this.onPointerDown,
    this.onPointerUp,
    this.onPointerEnter,
    this.onPointerLeave,
    this.onPointerMove,
    this.onPointerCancel,
    this.onPointerOver,
    this.onPointerOut,
    this.onMouseDown,
    this.onMouseUp,
    this.onMouseEnter,
    this.onMouseLeave,
    this.onMouseMove,
    this.onMouseOver,
    this.onMouseOut,
    this.onTouchStart,
    this.onTouchEnd,
    this.onTouchMove,
    this.onTouchCancel,
    super.key,
  });

  @override
  PaintedNode createNode();
}

mixin PaintedNode<T extends PaintedWidget, U extends html.Element> on Node<T> {
  U get element;

  late html.Animation? _animation;

  void initializeElement() {
    element
      ..addTypedEventListener('click', widget.onTap)
      ..addTypedEventListener('pointerdown', widget.onPointerDown)
      ..addTypedEventListener('pointerup', widget.onPointerUp)
      ..addTypedEventListener('pointerenter', widget.onPointerEnter)
      ..addTypedEventListener('pointerleave', widget.onPointerLeave)
      ..addTypedEventListener('pointermove', widget.onPointerMove)
      ..addTypedEventListener('pointercancel', widget.onPointerCancel)
      ..addTypedEventListener('pointerover', widget.onPointerOver)
      ..addTypedEventListener('pointerout', widget.onPointerOut)
      ..addTypedEventListener('mousedown', widget.onMouseDown)
      ..addTypedEventListener('mouseup', widget.onMouseUp)
      ..addTypedEventListener('mouseenter', widget.onMouseEnter)
      ..addTypedEventListener('mouseleave', widget.onMouseLeave)
      ..addTypedEventListener('mousemove', widget.onMouseMove)
      ..addTypedEventListener('mouseover', widget.onMouseOver)
      ..addTypedEventListener('mouseout', widget.onMouseOut)
      ..addTypedEventListener('touchstart', widget.onTouchStart)
      ..addTypedEventListener('touchend', widget.onTouchEnd)
      ..addTypedEventListener('touchmove', widget.onTouchMove)
      ..addTypedEventListener('touchcancel', widget.onTouchCancel);

    if (widget.style == null) {
      element.removeAttribute('style');
    } else {
      element.setAttribute('style', widget.style!.toString());
    }
  }

  void disposeElement() {
    element
      ..removeTypedEventListener('click', widget.onTap)
      ..removeTypedEventListener('pointerdown', widget.onPointerDown)
      ..removeTypedEventListener('pointerup', widget.onPointerUp)
      ..removeTypedEventListener('pointerenter', widget.onPointerEnter)
      ..removeTypedEventListener('pointerleave', widget.onPointerLeave)
      ..removeTypedEventListener('pointermove', widget.onPointerMove)
      ..removeTypedEventListener('pointercancel', widget.onPointerCancel)
      ..removeTypedEventListener('pointerover', widget.onPointerOver)
      ..removeTypedEventListener('pointerout', widget.onPointerOut)
      ..removeTypedEventListener('mousedown', widget.onMouseDown)
      ..removeTypedEventListener('mouseup', widget.onMouseUp)
      ..removeTypedEventListener('mouseenter', widget.onMouseEnter)
      ..removeTypedEventListener('mouseleave', widget.onMouseLeave)
      ..removeTypedEventListener('mousemove', widget.onMouseMove)
      ..removeTypedEventListener('mouseover', widget.onMouseOver)
      ..removeTypedEventListener('mouseout', widget.onMouseOut)
      ..removeTypedEventListener('touchstart', widget.onTouchStart)
      ..removeTypedEventListener('touchend', widget.onTouchEnd)
      ..removeTypedEventListener('touchmove', widget.onTouchMove)
      ..removeTypedEventListener('touchcancel', widget.onTouchCancel);
  }

  @override
  void initialize() {
    super.initialize();

    final parentPaintedNodes = parentNodes.whereType<PaintedNode>();

    if (parentPaintedNodes.isEmpty) {
      html.document.body!.append(element);
    } else {
      final parentPaintedNode = parentPaintedNodes.first;

      if (parentPaintedNode is SingleChildPaintedNode) {
        parentPaintedNode.element.append(element);
      } else if (parentPaintedNode is MultiChildPaintedNode) {
        final thisWithParentNodes = [this, ...parentNodes];

        final parentPaintedNodeChild =
            thisWithParentNodes.indexOf(parentPaintedNodes.first) - 1;

        final index = parentPaintedNode.childNodes
            .indexOf(thisWithParentNodes[parentPaintedNodeChild]);

        final parentElement = parentPaintedNode.element;

        if (parentElement.children.length <= index) {
          parentElement.append(element);
        } else {
          parentElement.insertBefore(element, parentElement.children[index]);
        }
      }
    }

    initializeElement();

    _animation = widget.animation?.runOnElement(element);
  }

  @override
  void widgetWillUpdate(final T newWidget) {
    disposeElement();
    super.widgetWillUpdate(newWidget);
  }

  @override
  void widgetDidUpdate(final T oldWidget) {
    super.widgetDidUpdate(oldWidget);
    initializeElement();
  }

  @override
  void dispose() {
    _animation?.cancel();
    disposeElement();
    element.remove();
    super.dispose();
  }
}

abstract class NoChildPaintedNode<T extends PaintedWidget,
    U extends html.Element> extends Node<T> with PaintedNode<T, U> {
  @override
  final U element;

  NoChildPaintedNode(super.widget, {required this.element});
}

abstract class SingleChildPaintedNode<T extends PaintedWidget,
    U extends html.Element> extends SingleChildNode<T> with PaintedNode<T, U> {
  @override
  final U element;

  SingleChildPaintedNode(super.widget, {required this.element});
}

abstract class MultiChildPaintedNode<T extends PaintedWidget,
    U extends html.Element> extends MultiChildNode<T> with PaintedNode<T, U> {
  @override
  final U element;

  MultiChildPaintedNode(super.widget, {required this.element});
}
