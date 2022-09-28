import 'dart:async';
import 'dart:html' as html;

import 'package:dawn/animation.dart';
import 'package:dawn/core.dart';

import 'widget.dart';

typedef EventSubscriptionCallback<T extends html.Event> = void Function(
  T event,
);

abstract class PaintedWidget extends Widget {
  final Style? style;
  final Animation? animation;

  final EventSubscriptionCallback<html.MouseEvent>? onTap;

  final EventSubscriptionCallback<html.PointerEvent>? onPointerDown;
  final EventSubscriptionCallback<html.PointerEvent>? onPointerUp;
  final EventSubscriptionCallback<html.PointerEvent>? onPointerEnter;
  final EventSubscriptionCallback<html.PointerEvent>? onPointerLeave;
  final EventSubscriptionCallback<html.PointerEvent>? onPointerMove;
  final EventSubscriptionCallback<html.PointerEvent>? onPointerCancel;
  final EventSubscriptionCallback<html.PointerEvent>? onPointerOver;
  final EventSubscriptionCallback<html.PointerEvent>? onPointerOut;

  final EventSubscriptionCallback<html.MouseEvent>? onMouseDown;
  final EventSubscriptionCallback<html.MouseEvent>? onMouseUp;
  final EventSubscriptionCallback<html.MouseEvent>? onMouseEnter;
  final EventSubscriptionCallback<html.MouseEvent>? onMouseLeave;
  final EventSubscriptionCallback<html.MouseEvent>? onMouseMove;
  final EventSubscriptionCallback<html.MouseEvent>? onMouseOver;
  final EventSubscriptionCallback<html.MouseEvent>? onMouseOut;

  final EventSubscriptionCallback<html.TouchEvent>? onTouchStart;
  final EventSubscriptionCallback<html.TouchEvent>? onTouchEnd;
  final EventSubscriptionCallback<html.TouchEvent>? onTouchMove;
  final EventSubscriptionCallback<html.TouchEvent>? onTouchCancel;

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

  final _eventSubscriptions = <StreamSubscription<html.Event>>[];

  late html.Animation? _animation;

  void addEventSubscription<V extends html.Event>({
    required final html.EventTarget target,
    required final String type,
    required final EventSubscriptionCallback<V>? callback,
  }) {
    if (callback != null) {
      _eventSubscriptions.add(
        element.on[type].listen(
          (final event) => callback(event as V),
        ),
      );
    }
  }

  void initializeElement() {
    addEventSubscription(
      target: element,
      type: 'click',
      callback: widget.onTap,
    );

    addEventSubscription(
      target: element,
      type: 'pointerdown',
      callback: widget.onPointerDown,
    );

    addEventSubscription(
      target: element,
      type: 'pointerup',
      callback: widget.onPointerUp,
    );

    addEventSubscription(
      target: element,
      type: 'pointerenter',
      callback: widget.onPointerEnter,
    );

    addEventSubscription(
      target: element,
      type: 'pointerleave',
      callback: widget.onPointerLeave,
    );

    addEventSubscription(
      target: element,
      type: 'pointermove',
      callback: widget.onPointerMove,
    );

    addEventSubscription(
      target: element,
      type: 'pointercancel',
      callback: widget.onPointerCancel,
    );

    addEventSubscription(
      target: element,
      type: 'pointerover',
      callback: widget.onPointerOver,
    );

    addEventSubscription(
      target: element,
      type: 'pointerout',
      callback: widget.onPointerOut,
    );

    addEventSubscription(
      target: element,
      type: 'mousedown',
      callback: widget.onMouseDown,
    );

    addEventSubscription(
      target: element,
      type: 'mouseup',
      callback: widget.onMouseUp,
    );

    addEventSubscription(
      target: element,
      type: 'mouseenter',
      callback: widget.onMouseEnter,
    );

    addEventSubscription(
      target: element,
      type: 'mouseleave',
      callback: widget.onMouseLeave,
    );

    addEventSubscription(
      target: element,
      type: 'mousemove',
      callback: widget.onMouseMove,
    );

    addEventSubscription(
      target: element,
      type: 'mouseover',
      callback: widget.onMouseOver,
    );

    addEventSubscription(
      target: element,
      type: 'mouseout',
      callback: widget.onMouseOut,
    );

    addEventSubscription(
      target: element,
      type: 'touchstart',
      callback: widget.onTouchStart,
    );

    addEventSubscription(
      target: element,
      type: 'touchend',
      callback: widget.onTouchEnd,
    );

    addEventSubscription(
      target: element,
      type: 'touchmove',
      callback: widget.onTouchMove,
    );

    addEventSubscription(
      target: element,
      type: 'touchcancel',
      callback: widget.onTouchCancel,
    );

    if (widget.style == null) {
      element.removeAttribute('style');
    } else {
      element.setAttribute('style', widget.style!.toString());
    }
  }

  void disposeElement() {
    for (final eventSubscription in _eventSubscriptions) {
      eventSubscription.cancel();
    }
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

abstract class ChildlessPaintedNode<T extends PaintedWidget,
    U extends html.Element> extends Node<T> with PaintedNode<T, U> {
  @override
  final U element;

  ChildlessPaintedNode(super.widget, {required this.element});
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
