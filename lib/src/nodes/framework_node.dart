import 'dart:html' as html;

import 'package:dawn/src/nodes.dart';
import 'package:dawn/src/widgets.dart';

abstract class FrameworkNode<T extends FrameworkWidget, U extends html.Element>
    extends Node<T> {
  final U element;

  html.Animation? animation;

  FrameworkNode(super.widget, {required this.element, super.parentNode});

  void initializeElement() {
    element
      ..addEventListener('pointerdown', widget.onPointerDown)
      ..addEventListener('pointerup', widget.onPointerUp)
      ..addEventListener('pointerenter', widget.onPointerEnter)
      ..addEventListener('pointerleave', widget.onPointerLeave)
      ..addEventListener('click', widget.onPress);

    if (widget.style == null) {
      element.removeAttribute('style');
    } else {
      element.setAttribute('style', widget.style!.toInline());
    }
  }

  void disposeElement() => element
    ..removeEventListener('pointerdown', widget.onPointerDown)
    ..removeEventListener('pointerup', widget.onPointerUp)
    ..removeEventListener('pointerenter', widget.onPointerEnter)
    ..removeEventListener('pointerleave', widget.onPointerLeave)
    ..removeEventListener('click', widget.onPress);

  @override
  void initialize() {
    super.initialize();

    final parentContainerNodes = parentsSequence.whereType<ContainerNode>();

    final parentElement = parentContainerNodes.isEmpty
        ? html.document.body!
        : parentContainerNodes.first.element;

    late final int index;

    if (parentContainerNodes.isEmpty) {
      index = 0;
    } else {
      final sequenceWithSelf = [this, ...parentsSequence];

      final immediateChildOfParentContainerIndex =
          sequenceWithSelf.indexOf(parentContainerNodes.first) - 1;

      index = parentContainerNodes.first.childNodes
          .indexOf(sequenceWithSelf[immediateChildOfParentContainerIndex]);
    }

    if (parentElement.children.length <= index) {
      parentElement.append(element);
    } else {
      parentElement.insertBefore(element, parentElement.children[index]);
    }

    initializeElement();

    if (widget.animation != null) {
      animation = widget.animation!.runOnElement(element);
    } else {
      animation = null;
    }
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
