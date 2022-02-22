import 'dart:async';
import 'dart:html';

import 'package:dawn/src/context.dart';
import 'package:dawn/src/widgets.dart';

typedef ChildNodes = List<Node<Widget>>;

Node<Widget> createNode(final Widget widget, {final Node<Widget>? parentNode}) {
  if (widget is StatelessWidget) {
    return StatelessNode(widget, parentNode: parentNode);
  } else if (widget is StatefulWidget) {
    return StatefulNode(widget, parentNode: parentNode);
  } else if (widget is Text) {
    return TextNode(widget, parentNode: parentNode);
  } else if (widget is Container) {
    return ContainerNode(widget, parentNode: parentNode);
  } else {
    throw TypeError();
  }
}

abstract class Node<T extends Widget> {
  abstract final T widget;

  final Context context;

  bool _isInitialized = false;

  Node({final Node<Widget>? parentNode})
      : context = parentNode != null
            ? Context([parentNode, ...parentNode.context.sequence])
            : const Context.empty();

  bool get isInitialized => _isInitialized;

  void initialize() => _isInitialized = true;
  void dispose() => _isInitialized = false;
}

class StatelessNode extends Node<StatelessWidget> {
  @override
  final StatelessWidget widget;

  late final childNode = createNode(widget.build(context), parentNode: this);

  StatelessNode(this.widget, {final Node<Widget>? parentNode})
      : super(parentNode: parentNode);

  @override
  void initialize() {
    super.initialize();
    childNode.initialize();
  }

  @override
  void dispose() {
    childNode.dispose();
    super.dispose();
  }
}

class StatefulNode extends Node<StatefulWidget> {
  @override
  final StatefulWidget widget;

  late final StreamSubscription<void> _updateStreamSubscription;

  late final State<StatefulWidget> _state = widget.createState()
    ..widget = widget
    ..context = context;

  late Node<Widget> _childNode =
      createNode(_state.build(context), parentNode: this);

  StatefulNode(this.widget, {final Node<Widget>? parentNode})
      : super(parentNode: parentNode);

  Node<Widget> get childNode => _childNode;

  void stateDidUpdate() {
    final oldChildNode = childNode;
    final newChildNode = createNode(_state.build(context), parentNode: this);

    if (newChildNode is FrameworkNode<FrameworkWidget, HtmlElement> &&
        oldChildNode is FrameworkNode<FrameworkWidget, HtmlElement> &&
        newChildNode.runtimeType == oldChildNode.runtimeType) {
      oldChildNode.setWidget(newChildNode.widget);
    } else if (newChildNode.widget != oldChildNode.widget) {
      oldChildNode.dispose();
      _childNode = newChildNode..initialize();
    }
  }

  @override
  void initialize() {
    super.initialize();
    _state.initialize();
    childNode.initialize();

    _updateStreamSubscription =
        _state.updateStream.listen((final event) => stateDidUpdate());

    _state.didMount();
  }

  @override
  void dispose() {
    _state.willUnmount();
    _updateStreamSubscription.cancel();
    childNode.dispose();
    _state.dispose();
    super.dispose();
  }
}

abstract class FrameworkNode<T extends FrameworkWidget, U extends HtmlElement>
    extends Node<T> {
  final U _element;

  T _widget;

  FrameworkNode(
    final T widget, {
    required final U element,
    final Node<Widget>? parentNode,
  })  : _widget = widget,
        _element = element,
        super(parentNode: parentNode);

  @override
  T get widget => _widget;

  void setWidget(final T newWidget) {
    if (widget != newWidget) {
      willWidgetChange();
      _widget = newWidget;
      onWidgetChange();
    }
  }

  void initializeElement() {
    _element.setAttribute('style', widget.styles.rules);

    widget
      ..onPointerDown?.forEach(
        (final listener) => _element.addEventListener('pointerdown', listener),
      )
      ..onPointerUp?.forEach(
        (final listener) => _element.addEventListener('pointerup', listener),
      )
      ..onPointerEnter?.forEach(
        (final listener) => _element.addEventListener('pointerenter', listener),
      )
      ..onPointerLeave?.forEach(
        (final listener) => _element.addEventListener('pointerleave', listener),
      )
      ..onPress?.forEach(
        (final listener) => _element.addEventListener('click', listener),
      );
  }

  void disposeElement() {
    widget
      ..onPointerDown?.forEach(
        (final listener) =>
            _element.removeEventListener('pointerdown', listener),
      )
      ..onPointerUp?.forEach(
        (final listener) => _element.removeEventListener('pointerup', listener),
      )
      ..onPointerEnter?.forEach(
        (final listener) =>
            _element.removeEventListener('pointerenter', listener),
      )
      ..onPointerLeave?.forEach(
        (final listener) =>
            _element.removeEventListener('pointerleave', listener),
      )
      ..onPress?.forEach(
        (final listener) => _element.removeEventListener('click', listener),
      );
  }

  void willWidgetChange() => disposeElement();
  void onWidgetChange() => initializeElement();

  @override
  void initialize() {
    super.initialize();

    final parentContainerNodes = context.sequence.whereType<ContainerNode>();

    final parentElement = parentContainerNodes.isEmpty
        ? document.body!
        : parentContainerNodes.first._element;

    late final int index;

    if (parentContainerNodes.isEmpty) {
      index = 0;
    } else {
      final sequenceWithSelf = [this, ...context.sequence];

      final immediateChildOfParentContainerIndex =
          sequenceWithSelf.indexOf(parentContainerNodes.first) - 1;

      index = parentContainerNodes.first.childNodes
          .indexOf(sequenceWithSelf[immediateChildOfParentContainerIndex]);
    }

    if (parentElement.children.length <= index) {
      parentElement.append(_element);
    } else {
      parentElement.insertBefore(_element, parentElement.children[index]);
    }

    initializeElement();
  }

  @override
  void dispose() {
    disposeElement();
    _element.remove();
    super.dispose();
  }
}

class TextNode extends FrameworkNode<Text, SpanElement> {
  TextNode(final Text widget, {final Node<Widget>? parentNode})
      : super(widget, element: SpanElement(), parentNode: parentNode);

  @override
  void initializeElement() {
    super.initializeElement();
    _element.text = widget.value;
  }
}

class ContainerNode extends FrameworkNode<Container, DivElement> {
  late ChildNodes _childNodes = widget.children
      .map((final child) => createNode(child, parentNode: this))
      .toList();

  ContainerNode(final Container widget, {final Node<Widget>? parentNode})
      : super(widget, element: DivElement(), parentNode: parentNode);

  ChildNodes get childNodes => List.unmodifiable(_childNodes);

  @override
  void onWidgetChange() {
    super.onWidgetChange();

    final oldChildNodes = childNodes;

    final newChildNodes = widget.children
        .map((final child) => createNode(child, parentNode: this))
        .toList();

    int searchIndex = 0;

    for (final oldChildNode in oldChildNodes) {
      final index = newChildNodes.indexWhere(
        (final newChildNode) =>
            newChildNode.runtimeType == oldChildNode.runtimeType,
        searchIndex,
      );

      if (index < 0) {
        oldChildNode.dispose();
      } else {
        final newChildNode = newChildNodes[index];

        searchIndex = index + 1;

        if (newChildNode is FrameworkNode<FrameworkWidget, HtmlElement> &&
            oldChildNode is FrameworkNode<FrameworkWidget, HtmlElement>) {
          oldChildNode.setWidget(newChildNode.widget);

          newChildNodes[index] = oldChildNode;
        } else if (newChildNode.widget == oldChildNode.widget) {
          newChildNodes[index] = oldChildNode;
        }
      }
    }

    _childNodes = newChildNodes;

    for (final childNode in childNodes) {
      if (!childNode.isInitialized) childNode.initialize();
    }
  }

  @override
  void initialize() {
    super.initialize();

    for (final childNode in childNodes) {
      childNode.initialize();
    }
  }

  @override
  void dispose() {
    for (final childNode in childNodes) {
      childNode.dispose();
    }

    super.dispose();
  }
}
