part of dawn;

Node<Widget> _createNode(
  final Widget widget, {
  final Node<Widget>? parentNode,
}) {
  if (widget is StatelessWidget) {
    return StatelessNode(widget, parentNode: parentNode);
  } else if (widget is StatefulWidget) {
    return StatefulNode(widget, parentNode: parentNode);
  } else if (widget is Text) {
    return TextNode(widget, parentNode: parentNode);
  } else if (widget is Image) {
    return ImageNode(widget, parentNode: parentNode);
  } else if (widget is Input) {
    return InputNode(widget, parentNode: parentNode);
  } else if (widget is TextBox) {
    return TextBoxNode(widget, parentNode: parentNode);
  } else if (widget is Container) {
    return ContainerNode(widget, parentNode: parentNode);
  } else {
    throw TypeError();
  }
}

abstract class Node<T extends Widget> {
  abstract final T widget;

  final Context context;

  Node({final Node<Widget>? parentNode})
      : context = parentNode != null
            ? Context([parentNode, ...parentNode.context.sequence])
            : const Context.empty();

  void _initialize();
  void _dispose();
}

class StatelessNode extends Node<StatelessWidget> {
  @override
  final StatelessWidget widget;

  late final _childNode = _createNode(widget.build(context), parentNode: this);

  StatelessNode(this.widget, {final Node<Widget>? parentNode})
      : super(parentNode: parentNode);

  @override
  void _initialize() => _childNode._initialize();

  @override
  void _dispose() => _childNode._dispose();
}

class StatefulNode extends Node<StatefulWidget> {
  @override
  final StatefulWidget widget;

  late final StreamSubscription<void> _updateStreamSubscription;
  late final State<StatefulWidget> _state;

  late Node<Widget> _childNode;

  StatefulNode(this.widget, {final Node<Widget>? parentNode})
      : super(parentNode: parentNode);

  void _stateDidUpdate() {
    final oldChildNode = _childNode;
    final newChildNode = _createNode(_state.build(context), parentNode: this);

    if (newChildNode is FrameworkNode<FrameworkWidget, html.Element> &&
        oldChildNode is FrameworkNode<FrameworkWidget, html.Element> &&
        newChildNode.runtimeType == oldChildNode.runtimeType) {
      oldChildNode._setWidget(newChildNode.widget);
    } else if (newChildNode.widget != oldChildNode.widget) {
      oldChildNode._dispose();
      _childNode = newChildNode.._initialize();
    }
  }

  @override
  void _initialize() {
    _state = widget.createState()
      ..widget = widget
      ..context = context
      ..initialize();

    _childNode = _createNode(_state.build(context), parentNode: this)
      .._initialize();

    _updateStreamSubscription = _state.onUpdate(_stateDidUpdate);

    _state.didMount();
  }

  @override
  void _dispose() {
    _state.willUnmount();
    _updateStreamSubscription.cancel();
    _childNode._dispose();
    _state.dispose();
  }
}

abstract class FrameworkNode<T extends FrameworkWidget, U extends html.Element>
    extends Node<T> {
  final U _element;

  T _widget;

  html.Animation? _animation;

  FrameworkNode(
    final T widget, {
    required final U element,
    final Node<Widget>? parentNode,
  })  : _widget = widget,
        _element = element,
        super(parentNode: parentNode);

  @override
  T get widget => _widget;

  void _setWidget(final T newWidget) {
    if (widget != newWidget) {
      _willWidgetChange();
      _widget = newWidget;
      _didWidgetChange();
    }
  }

  void _initializeElement() {
    _element
      ..addEventListener('pointerdown', widget.onPointerDown)
      ..addEventListener('pointerup', widget.onPointerUp)
      ..addEventListener('pointerenter', widget.onPointerEnter)
      ..addEventListener('pointerleave', widget.onPointerLeave)
      ..addEventListener('click', widget.onPress);

    if (widget.style != null) {
      _element.setAttribute('style', widget.style!.toString());
    }

    if (widget.animation != null) {
      _animation = _element.animate(
        widget.animation!.keyframes,
        widget.animation!.options,
      );
    } else {
      _animation = null;
    }
  }

  void _disposeElement() {
    _animation?.cancel();

    _element
      ..removeAttribute('style')
      ..removeEventListener('pointerdown', widget.onPointerDown)
      ..removeEventListener('pointerup', widget.onPointerUp)
      ..removeEventListener('pointerenter', widget.onPointerEnter)
      ..removeEventListener('pointerleave', widget.onPointerLeave)
      ..removeEventListener('click', widget.onPress);
  }

  void _willWidgetChange() => _disposeElement();
  void _didWidgetChange() => _initializeElement();

  @override
  void _initialize() {
    final parentContainerNodes = context.sequence.whereType<ContainerNode>();

    final parentElement = parentContainerNodes.isEmpty
        ? html.document.body!
        : parentContainerNodes.first._element;

    late final int index;

    if (parentContainerNodes.isEmpty) {
      index = 0;
    } else {
      final sequenceWithSelf = [this, ...context.sequence];

      final immediateChildOfParentContainerIndex =
          sequenceWithSelf.indexOf(parentContainerNodes.first) - 1;

      index = parentContainerNodes.first._childNodes
          .indexOf(sequenceWithSelf[immediateChildOfParentContainerIndex]);
    }

    if (parentElement.children.length <= index) {
      parentElement.append(_element);
    } else {
      parentElement.insertBefore(_element, parentElement.children[index]);
    }

    _initializeElement();
  }

  @override
  void _dispose() {
    _disposeElement();
    _element.remove();
  }
}

class TextNode extends FrameworkNode<Text, html.SpanElement> {
  TextNode(final Text widget, {final Node<Widget>? parentNode})
      : super(widget, element: html.SpanElement(), parentNode: parentNode);

  @override
  void _initializeElement() {
    super._initializeElement();
    _element.text = widget.value;
  }

  @override
  void _disposeElement() {
    _element.text = '';
    super._disposeElement();
  }
}

class ImageNode extends FrameworkNode<Image, html.ImageElement> {
  ImageNode(final Image widget, {final Node<Widget>? parentNode})
      : super(widget, element: html.ImageElement(), parentNode: parentNode);

  @override
  void _initializeElement() {
    super._initializeElement();
    _element.src = widget.source;
  }

  @override
  void _disposeElement() {
    _element.src = '';
    super._disposeElement();
  }
}

typedef ChildNodes = List<Node<Widget>>;

class ContainerNode extends FrameworkNode<Container, html.DivElement> {
  late ChildNodes _childNodes = widget.children
      .map((final child) => _createNode(child, parentNode: this))
      .toList();

  ContainerNode(final Container widget, {final Node<Widget>? parentNode})
      : super(widget, element: html.DivElement(), parentNode: parentNode);

  @override
  void _didWidgetChange() {
    super._didWidgetChange();

    final oldChildNodes = _childNodes;

    final newChildNodes = widget.children
        .map((final child) => _createNode(child, parentNode: this))
        .toList();

    int exactSearchStartIndex = 0;
    int sameTypeSearchStartIndex = 0;

    for (final oldChildNode in oldChildNodes) {
      final index = newChildNodes.indexWhere(
        (final newChildNode) => newChildNode.widget == oldChildNode.widget,
        exactSearchStartIndex,
      );

      if (index > -1) {
        newChildNodes[index] = oldChildNode;
        exactSearchStartIndex = index + 1;
      }
    }

    for (final oldChildNode in oldChildNodes) {
      if (!newChildNodes.contains(oldChildNode)) {
        final index = newChildNodes.indexWhere(
          (final newChildNode) =>
              oldChildNode is FrameworkNode<FrameworkWidget, html.Element> &&
              newChildNode.runtimeType == oldChildNode.runtimeType,
          sameTypeSearchStartIndex,
        );

        if (index > -1) {
          final newChildNode = newChildNodes[index];

          if (!oldChildNodes.contains(newChildNode) &&
              oldChildNode is FrameworkNode<FrameworkWidget, html.Element> &&
              newChildNode is FrameworkNode<FrameworkWidget, html.Element>) {
            oldChildNode._setWidget(newChildNode.widget);
            newChildNodes[index] = oldChildNode;
            sameTypeSearchStartIndex = index + 1;
          }
        }
      }
    }

    for (final childNode in _childNodes) {
      if (!newChildNodes.contains(childNode)) childNode._dispose();
    }

    _childNodes = newChildNodes;

    for (final childNode in _childNodes) {
      if (!oldChildNodes.contains(childNode)) childNode._initialize();
    }
  }

  @override
  void _initialize() {
    super._initialize();

    for (final childNode in _childNodes) {
      childNode._initialize();
    }
  }

  @override
  void _dispose() {
    for (final childNode in _childNodes) {
      childNode._dispose();
    }

    super._dispose();
  }
}

class UserInputNode<T extends UserInputWidget, U extends html.Element>
    extends FrameworkNode<T, U> {
  UserInputNode(
    final T widget, {
    required final U element,
    final Node<Widget>? parentNode,
  }) : super(widget, element: element, parentNode: parentNode);

  @override
  void _initializeElement() {
    super._initializeElement();

    widget.userInputController
      .._element = _element
      .._initialize();
  }

  @override
  void _disposeElement() {
    widget.userInputController._dispose();
    super._disposeElement();
  }
}

class InputNode extends UserInputNode<Input, html.TextInputElement> {
  InputNode(final Input widget, {final Node<Widget>? parentNode})
      : super(widget, element: html.TextInputElement(), parentNode: parentNode);
}

class TextBoxNode extends UserInputNode<TextBox, html.TextAreaElement> {
  TextBoxNode(final TextBox widget, {final Node<Widget>? parentNode})
      : super(widget, element: html.TextAreaElement(), parentNode: parentNode);
}
