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

  final EventCallback? onTap;

  final PointerEventCallback? onPointerDown;
  final PointerEventCallback? onPointerUp;
  final PointerEventCallback? onPointerEnter;
  final PointerEventCallback? onPointerLeave;
  final PointerEventCallback? onPointerMove;
  final PointerEventCallback? onPointerCancel;
  final PointerEventCallback? onPointerOver;
  final PointerEventCallback? onPointerOut;

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
    super.key,
    super.ref,
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

  void addEventSubscription<V extends html.Event, W extends EventDetails<V>>({
    required final String type,
    required final EventCallback<W>? callback,
    required final W Function(V event) eventTransformer,
  }) {
    if (callback != null) {
      _eventSubscriptions.add(
        element.on[type].listen(
          (final event) => callback(eventTransformer(event as V)),
        ),
      );
    }
  }

  /// Called when this [Node] is added to the tree or after the [widget] is
  /// updated.
  void initializeElement() {
    addEventSubscription(
      type: 'click',
      callback: widget.onTap,
      eventTransformer: (final html.Event event) => EventDetails(
        event,
        targetNode: this,
      ),
    );

    addEventSubscription(
      type: 'pointerdown',
      callback: widget.onPointerDown,
      eventTransformer: (final html.PointerEvent event) => PointerEventDetails(
        event,
        targetNode: this,
      ),
    );

    addEventSubscription(
      type: 'pointerup',
      callback: widget.onPointerUp,
      eventTransformer: (final html.PointerEvent event) => PointerEventDetails(
        event,
        targetNode: this,
      ),
    );

    addEventSubscription(
      type: 'pointerenter',
      callback: widget.onPointerEnter,
      eventTransformer: (final html.PointerEvent event) => PointerEventDetails(
        event,
        targetNode: this,
      ),
    );

    addEventSubscription(
      type: 'pointerleave',
      callback: widget.onPointerLeave,
      eventTransformer: (final html.PointerEvent event) => PointerEventDetails(
        event,
        targetNode: this,
      ),
    );

    addEventSubscription(
      type: 'pointermove',
      callback: widget.onPointerMove,
      eventTransformer: (final html.PointerEvent event) => PointerEventDetails(
        event,
        targetNode: this,
      ),
    );

    addEventSubscription(
      type: 'pointercancel',
      callback: widget.onPointerCancel,
      eventTransformer: (final html.PointerEvent event) => PointerEventDetails(
        event,
        targetNode: this,
      ),
    );

    addEventSubscription(
      type: 'pointerover',
      callback: widget.onPointerOver,
      eventTransformer: (final html.PointerEvent event) => PointerEventDetails(
        event,
        targetNode: this,
      ),
    );

    addEventSubscription(
      type: 'pointerout',
      callback: widget.onPointerOut,
      eventTransformer: (final html.PointerEvent event) => PointerEventDetails(
        event,
        targetNode: this,
      ),
    );

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
