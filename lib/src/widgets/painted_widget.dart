import 'dart:html' as html;

import 'package:dawn/animation.dart';
import 'package:dawn/foundation.dart';

import 'container.dart';
import 'widget.dart';

abstract class PaintedWidget extends Widget {
  final Style? style;
  final Animation? animation;

  final EventListener? onTap;

  final EventListener? onPointerDown;
  final EventListener? onPointerUp;
  final EventListener? onPointerEnter;
  final EventListener? onPointerLeave;
  final EventListener? onPointerMove;
  final EventListener? onPointerCancel;
  final EventListener? onPointerOver;
  final EventListener? onPointerOut;

  final EventListener? onMouseDown;
  final EventListener? onMouseUp;
  final EventListener? onMouseEnter;
  final EventListener? onMouseLeave;
  final EventListener? onMouseMove;
  final EventListener? onMouseOver;
  final EventListener? onMouseOut;

  final EventListener? onTouchStart;
  final EventListener? onTouchEnd;
  final EventListener? onTouchMove;
  final EventListener? onTouchCancel;

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

abstract class PaintedNode<T extends PaintedWidget, U extends html.Element>
    extends Node<T> {
  final U element;
  late html.Animation? _animation;

  PaintedNode(super.widget, {required this.element});

  @override
  void updateSubtree() {}

  void initializeElement() {
    element
      ..addEventListener('click', widget.onTap)
      ..addEventListener('pointerdown', widget.onPointerDown)
      ..addEventListener('pointerup', widget.onPointerUp)
      ..addEventListener('pointerenter', widget.onPointerEnter)
      ..addEventListener('pointerleave', widget.onPointerLeave)
      ..addEventListener('pointermove', widget.onPointerMove)
      ..addEventListener('pointercancel', widget.onPointerCancel)
      ..addEventListener('pointerover', widget.onPointerOver)
      ..addEventListener('pointerout', widget.onPointerOut)
      ..addEventListener('mousedown', widget.onMouseDown)
      ..addEventListener('mouseup', widget.onMouseUp)
      ..addEventListener('mouseenter', widget.onMouseEnter)
      ..addEventListener('mouseleave', widget.onMouseLeave)
      ..addEventListener('mousemove', widget.onMouseMove)
      ..addEventListener('mouseover', widget.onMouseOver)
      ..addEventListener('mouseout', widget.onMouseOut)
      ..addEventListener('touchstart', widget.onTouchStart)
      ..addEventListener('touchend', widget.onTouchEnd)
      ..addEventListener('touchmove', widget.onTouchMove)
      ..addEventListener('touchcancel', widget.onTouchCancel);

    if (widget.style == null) {
      element.removeAttribute('style');
    } else {
      element.setAttribute('style', widget.style!.toString());
    }

    _animation = widget.animation?.runOnElement(element);
  }

  void disposeElement() {
    _animation?.cancel();

    element
      ..removeEventListener('click', widget.onTap)
      ..removeEventListener('pointerdown', widget.onPointerDown)
      ..removeEventListener('pointerup', widget.onPointerUp)
      ..removeEventListener('pointerenter', widget.onPointerEnter)
      ..removeEventListener('pointerleave', widget.onPointerLeave)
      ..removeEventListener('pointermove', widget.onPointerMove)
      ..removeEventListener('pointercancel', widget.onPointerCancel)
      ..removeEventListener('pointerover', widget.onPointerOver)
      ..removeEventListener('pointerout', widget.onPointerOut)
      ..removeEventListener('mousedown', widget.onMouseDown)
      ..removeEventListener('mouseup', widget.onMouseUp)
      ..removeEventListener('mouseenter', widget.onMouseEnter)
      ..removeEventListener('mouseleave', widget.onMouseLeave)
      ..removeEventListener('mousemove', widget.onMouseMove)
      ..removeEventListener('mouseover', widget.onMouseOver)
      ..removeEventListener('mouseout', widget.onMouseOut)
      ..removeEventListener('touchstart', widget.onTouchStart)
      ..removeEventListener('touchend', widget.onTouchEnd)
      ..removeEventListener('touchmove', widget.onTouchMove)
      ..removeEventListener('touchcancel', widget.onTouchCancel);
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
    disposeElement();
    element.remove();
    super.dispose();
  }
}
