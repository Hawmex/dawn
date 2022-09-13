import 'dart:html' as html;

import 'package:dawn/animation.dart';
import 'package:dawn/foundation.dart';

import 'container.dart';
import 'widget.dart';

/// The base class for widgets that render an [html.Element].
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
      ..addListener('click', widget.onTap)
      ..addListener('pointerdown', widget.onPointerDown)
      ..addListener('pointerup', widget.onPointerUp)
      ..addListener('pointerenter', widget.onPointerEnter)
      ..addListener('pointerleave', widget.onPointerLeave)
      ..addListener('pointermove', widget.onPointerMove)
      ..addListener('pointercancel', widget.onPointerCancel)
      ..addListener('pointerover', widget.onPointerOver)
      ..addListener('pointerout', widget.onPointerOut)
      ..addListener('mousedown', widget.onMouseDown)
      ..addListener('mouseup', widget.onMouseUp)
      ..addListener('mouseenter', widget.onMouseEnter)
      ..addListener('mouseleave', widget.onMouseLeave)
      ..addListener('mousemove', widget.onMouseMove)
      ..addListener('mouseover', widget.onMouseOver)
      ..addListener('mouseout', widget.onMouseOut)
      ..addListener('touchstart', widget.onTouchStart)
      ..addListener('touchend', widget.onTouchEnd)
      ..addListener('touchmove', widget.onTouchMove)
      ..addListener('touchcancel', widget.onTouchCancel);

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
      ..removeListener('click', widget.onTap)
      ..removeListener('pointerdown', widget.onPointerDown)
      ..removeListener('pointerup', widget.onPointerUp)
      ..removeListener('pointerenter', widget.onPointerEnter)
      ..removeListener('pointerleave', widget.onPointerLeave)
      ..removeListener('pointermove', widget.onPointerMove)
      ..removeListener('pointercancel', widget.onPointerCancel)
      ..removeListener('pointerover', widget.onPointerOver)
      ..removeListener('pointerout', widget.onPointerOut)
      ..removeListener('mousedown', widget.onMouseDown)
      ..removeListener('mouseup', widget.onMouseUp)
      ..removeListener('mouseenter', widget.onMouseEnter)
      ..removeListener('mouseleave', widget.onMouseLeave)
      ..removeListener('mousemove', widget.onMouseMove)
      ..removeListener('mouseover', widget.onMouseOver)
      ..removeListener('mouseout', widget.onMouseOut)
      ..removeListener('touchstart', widget.onTouchStart)
      ..removeListener('touchend', widget.onTouchEnd)
      ..removeListener('touchmove', widget.onTouchMove)
      ..removeListener('touchcancel', widget.onTouchCancel);
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
