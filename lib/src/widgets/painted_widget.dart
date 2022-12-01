import 'dart:async';
import 'dart:html' as html;

import 'package:dawn/animation.dart';
import 'package:dawn/core.dart';

import 'widget.dart';

typedef EventSubscriptionCallback<T extends html.Event> = void Function(
  T event,
);

/// The base class for widgets that paint an [html.Element].
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

/// A [Node] corresponding to [PaintedWidget].
mixin PaintedNode<T extends PaintedWidget, U extends html.Element> on Node<T> {
  /// The corresponding [html.Element] to this [PaintedNode].
  U get element;

  final _eventSubscriptions = <StreamSubscription<html.Event>>{};

  late final html.Animation? _animation;

  void addEventSubscription<V extends html.Event>(
    final String type,
    final EventSubscriptionCallback<V>? callback,
  ) {
    if (callback != null) {
      _eventSubscriptions.add(
        element.on[type].listen(
          (final event) => callback(event as V),
        ),
      );
    }
  }

  /// Called when this [Node] is added to the tree or after the [widget] is
  /// updated.
  void initializeElement() {
    addEventSubscription('click', widget.onTap);
    addEventSubscription('pointerdown', widget.onPointerDown);
    addEventSubscription('pointerup', widget.onPointerUp);
    addEventSubscription('pointerenter', widget.onPointerEnter);
    addEventSubscription('pointerleave', widget.onPointerLeave);
    addEventSubscription('pointermove', widget.onPointerMove);
    addEventSubscription('pointercancel', widget.onPointerCancel);
    addEventSubscription('pointerover', widget.onPointerOver);
    addEventSubscription('pointerout', widget.onPointerOut);
    addEventSubscription('mousedown', widget.onMouseDown);
    addEventSubscription('mouseup', widget.onMouseUp);
    addEventSubscription('mouseenter', widget.onMouseEnter);
    addEventSubscription('mouseleave', widget.onMouseLeave);
    addEventSubscription('mousemove', widget.onMouseMove);
    addEventSubscription('mouseover', widget.onMouseOver);
    addEventSubscription('mouseout', widget.onMouseOut);
    addEventSubscription('touchstart', widget.onTouchStart);
    addEventSubscription('touchend', widget.onTouchEnd);
    addEventSubscription('touchmove', widget.onTouchMove);
    addEventSubscription('touchcancel', widget.onTouchCancel);

    if (widget.style == null) {
      element.removeAttribute('style');
    } else {
      element.setAttribute('style', widget.style!.toString());
    }
  }

  /// Called before the [widget] is updated or when this [Node] is removed from
  /// the tree.
  void disposeElement() {
    for (final eventSubscription in _eventSubscriptions) {
      eventSubscription.cancel();
    }

    _eventSubscriptions.clear();
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

/// A [PaintedNode] with no children.
abstract class ChildlessPaintedNode<T extends PaintedWidget,
    U extends html.Element> extends Node<T> with PaintedNode<T, U> {
  @override
  final U element;

  ChildlessPaintedNode(super.widget, {required this.element});
}

/// A [PaintedNode] with one child.
abstract class SingleChildPaintedNode<T extends PaintedWidget,
    U extends html.Element> extends SingleChildNode<T> with PaintedNode<T, U> {
  @override
  final U element;

  SingleChildPaintedNode(super.widget, {required this.element});
}

/// A [PaintedNode] with multiple children.
abstract class MultiChildPaintedNode<T extends PaintedWidget,
    U extends html.Element> extends MultiChildNode<T> with PaintedNode<T, U> {
  @override
  final U element;

  MultiChildPaintedNode(super.widget, {required this.element});
}
