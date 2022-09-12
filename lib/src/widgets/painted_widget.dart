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
      ..on['click'].cast<html.MouseEvent>().listen(widget.onTap)
      ..on['pointerdown'].cast<html.PointerEvent>().listen(widget.onPointerDown)
      ..on['pointerup'].cast<html.PointerEvent>().listen(widget.onPointerUp)
      ..on['pointerenter']
          .cast<html.PointerEvent>()
          .listen(widget.onPointerEnter)
      ..on['pointerleave']
          .cast<html.PointerEvent>()
          .listen(widget.onPointerLeave)
      ..on['pointermove'].cast<html.PointerEvent>().listen(widget.onPointerMove)
      ..on['pointercancel']
          .cast<html.PointerEvent>()
          .listen(widget.onPointerCancel)
      ..on['pointerover'].cast<html.PointerEvent>().listen(widget.onPointerOver)
      ..on['pointerout'].cast<html.PointerEvent>().listen(widget.onPointerOut)
      ..on['mousedown'].cast<html.MouseEvent>().listen(widget.onMouseDown)
      ..on['mouseup'].cast<html.MouseEvent>().listen(widget.onMouseUp)
      ..on['mouseenter'].cast<html.MouseEvent>().listen(widget.onMouseEnter)
      ..on['mouseleave'].cast<html.MouseEvent>().listen(widget.onMouseLeave)
      ..on['mousemove'].cast<html.MouseEvent>().listen(widget.onMouseMove)
      ..on['mouseover'].cast<html.MouseEvent>().listen(widget.onMouseOver)
      ..on['mouseout'].cast<html.MouseEvent>().listen(widget.onMouseOut)
      ..on['touchstart'].cast<html.TouchEvent>().listen(widget.onTouchStart)
      ..on['touchend'].cast<html.TouchEvent>().listen(widget.onTouchEnd)
      ..on['touchmove'].cast<html.TouchEvent>().listen(widget.onTouchMove)
      ..on['touchcancel'].cast<html.TouchEvent>().listen(widget.onTouchCancel);

    if (widget.style == null) {
      element.removeAttribute('style');
    } else {
      element.setAttribute('style', widget.style!.toString());
    }
  }

  /// Called before the [widget] is updated or when this [Node] is removed from
  /// the tree.
  void disposeElement() {}

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
