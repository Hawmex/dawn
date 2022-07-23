import 'dart:html' as html;

import 'package:dawn/foundation.dart';
import 'package:dawn/widgets.dart';

import 'container_node.dart';
import 'node.dart';

abstract class FrameworkNode<T extends FrameworkWidget, U extends html.Element>
    extends Node<T> {
  final U element;

  html.Animation? animation;

  FrameworkNode({
    required super.widget,
    required this.element,
    super.parentNode,
  });

  void addListener<T extends html.Event>({
    required final String type,
    required final EventListener<T>? listener,
  }) =>
      element.addEventListener(type, listener as EventListener);

  void removeListener<T extends html.Event>({
    required final String type,
    required final EventListener<T>? listener,
  }) =>
      element.removeEventListener(type, listener as EventListener);

  void initializeElement() {
    addListener(type: 'click', listener: widget.onPress);

    addListener(type: 'pointerdown', listener: widget.onPointerDown);
    addListener(type: 'pointerup', listener: widget.onPointerUp);
    addListener(type: 'pointerenter', listener: widget.onPointerEnter);
    addListener(type: 'pointerleave', listener: widget.onPointerLeave);
    addListener(type: 'pointermove', listener: widget.onPointerMove);
    addListener(type: 'pointercancel', listener: widget.onPointerCancel);
    addListener(type: 'pointerover', listener: widget.onPointerOver);
    addListener(type: 'pointerout', listener: widget.onPointerOut);

    addListener(type: 'mousedown', listener: widget.onMouseDown);
    addListener(type: 'mouseup', listener: widget.onMouseUp);
    addListener(type: 'mouseenter', listener: widget.onMouseEnter);
    addListener(type: 'mouseleave', listener: widget.onMouseLeave);
    addListener(type: 'mousemove', listener: widget.onMouseMove);
    addListener(type: 'mouseover', listener: widget.onMouseOver);
    addListener(type: 'mouseout', listener: widget.onMouseOut);

    addListener(type: 'touchstart', listener: widget.onTouchStart);
    addListener(type: 'touchend', listener: widget.onTouchEnd);
    addListener(type: 'touchmove', listener: widget.onTouchMove);
    addListener(type: 'touchcancel', listener: widget.onTouchCancel);

    if (widget.style == null) {
      element.removeAttribute('style');
    } else {
      element.setAttribute('style', widget.style!.toString());
    }
  }

  void disposeElement() {
    removeListener(type: 'click', listener: widget.onPress);

    removeListener(type: 'pointerdown', listener: widget.onPointerDown);
    removeListener(type: 'pointerup', listener: widget.onPointerUp);
    removeListener(type: 'pointerenter', listener: widget.onPointerEnter);
    removeListener(type: 'pointerleave', listener: widget.onPointerLeave);
    removeListener(type: 'pointermove', listener: widget.onPointerMove);
    removeListener(type: 'pointercancel', listener: widget.onPointerCancel);
    removeListener(type: 'pointerover', listener: widget.onPointerOver);
    removeListener(type: 'pointerout', listener: widget.onPointerOut);

    removeListener(type: 'mousedown', listener: widget.onMouseDown);
    removeListener(type: 'mouseup', listener: widget.onMouseUp);
    removeListener(type: 'mouseenter', listener: widget.onMouseEnter);
    removeListener(type: 'mouseleave', listener: widget.onMouseLeave);
    removeListener(type: 'mousemove', listener: widget.onMouseMove);
    removeListener(type: 'mouseover', listener: widget.onMouseOver);
    removeListener(type: 'mouseout', listener: widget.onMouseOut);

    removeListener(type: 'touchstart', listener: widget.onTouchStart);
    removeListener(type: 'touchend', listener: widget.onTouchEnd);
    removeListener(type: 'touchmove', listener: widget.onTouchMove);
    removeListener(type: 'touchcancel', listener: widget.onTouchCancel);
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
    animation = widget.animation?.runOnElement(element);
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
    animation?.cancel();
    disposeElement();
    element.remove();
    super.dispose();
  }
}
