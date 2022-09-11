import 'dart:html' as html;

import 'package:dawn/animation.dart';
import 'package:dawn/foundation.dart';

import 'container.dart';
import 'widget.dart';

/// The base class for widgets that render an [html.Element].
abstract class PaintedWidget extends Widget {
  final Style? style;
  final Animation? animation;

  final EventListener<html.PointerEvent>? onTap;

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

/// An instantiation of a [PaintedWidget] at a particular location in the tree.
abstract class PaintedNode<T extends PaintedWidget, U extends html.Element>
    extends Node<T> {
  /// The corresponding [html.Element] to this [PaintedNode].
  final U element;

  late html.Animation? _animation;

  PaintedNode(super.widget, {required this.element});

  @override
  void updateSubtree() {}

  /// Called when this [Node] is added to the tree or after the [widget] is
  /// updated.
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

  /// Called before the [widget] is updated or when this [Node] is removed from
  /// the tree.
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

    final parentContainerNodes = parentNodes.whereType<ContainerNode>();

    final parentElement = parentContainerNodes.isEmpty
        ? html.document.body!
        : parentContainerNodes.first.element;

    late final int index;

    if (parentContainerNodes.isEmpty) {
      index = 0;
    } else {
      final thisWithParentNodes = [this, ...parentNodes];

      final immediateChildOfParentContainerIndex =
          thisWithParentNodes.indexOf(parentContainerNodes.first) - 1;

      index = parentContainerNodes.first.childNodes
          .indexOf(thisWithParentNodes[immediateChildOfParentContainerIndex]);
    }

    if (parentElement.children.length <= index) {
      parentElement.append(element);
    } else {
      parentElement.insertBefore(element, parentElement.children[index]);
    }

    initializeElement();

    _animation = widget.animation?.runOnElement(element);
  }

  @override
  void willWidgetUpdate(final T newWidget) {
    disposeElement();
    super.willWidgetUpdate(newWidget);
  }

  @override
  void didWidgetUpdate(final T oldWidget) {
    super.didWidgetUpdate(oldWidget);
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
