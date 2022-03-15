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
  } else if (widget is Container) {
    return ContainerNode(widget, parentNode: parentNode);
  } else {
    throw TypeError();
  }
}

abstract class Node<T extends Widget> {
  final Context context;

  T _widget;

  Node(this._widget, {final Node<Widget>? parentNode})
      : context = parentNode != null
            ? Context([parentNode, ...parentNode.context.sequence])
            : const Context.empty();

  T get widget => _widget;

  void _setWidget(final T newWidget) {
    if (widget != newWidget) {
      final oldWidget = _widget;

      _willWidgetUpdate(newWidget);
      _widget = newWidget;
      _didWidgetUpdate(oldWidget);
    }
  }

  void _initialize() {}
  void _willWidgetUpdate(final T newWidget) {}
  void _didWidgetUpdate(final T oldWidget) {}
  void _dispose() {}
}

class StatelessNode extends Node<StatelessWidget> {
  late Node<Widget> _childNode;

  StatelessNode(
    final StatelessWidget widget, {
    final Node<Widget>? parentNode,
  }) : super(widget, parentNode: parentNode);

  @override
  void _initialize() {
    super._initialize();

    _childNode = _createNode(
      widget.build(context),
      parentNode: this,
    ).._initialize();
  }

  @override
  void _didWidgetUpdate(final StatelessWidget oldWidget) {
    super._didWidgetUpdate(oldWidget);

    final newChildWidget = widget.build(context);

    if (_childNode.widget.runtimeType == newChildWidget.runtimeType) {
      _childNode._setWidget(newChildWidget);
    } else {
      _childNode._dispose();
      _childNode = _createNode(newChildWidget, parentNode: this);
    }
  }

  @override
  void _dispose() {
    _childNode._dispose();
    super._dispose();
  }
}

class StatefulNode extends Node<StatefulWidget> {
  late State<StatefulWidget> _state;
  late StreamSubscription<void> _updateStreamSubscription;
  late Node<Widget> _childNode;

  StatefulNode(
    final StatefulWidget widget, {
    final Node<Widget>? parentNode,
  }) : super(widget, parentNode: parentNode);

  @override
  void _initialize() {
    super._initialize();

    _state = widget.createState()
      .._widget = widget
      ..context = context
      ..initialize();

    _childNode = _createNode(
      _state.build(context),
      parentNode: this,
    ).._initialize();

    _updateStreamSubscription = _state.onUpdate(_stateDidUpdate);

    _state.didMount();
  }

  void _stateDidUpdate() {
    final newChildWidget = _state.build(context);

    if (_childNode.widget.runtimeType == newChildWidget.runtimeType) {
      _childNode._setWidget(newChildWidget);
    } else {
      _childNode._dispose();
      _childNode = _createNode(newChildWidget, parentNode: this).._initialize();
    }
  }

  @override
  void _didWidgetUpdate(final StatefulWidget oldWidget) {
    super._didWidgetUpdate(oldWidget);
    _state._widget = widget;
    _stateDidUpdate();
  }

  @override
  void _dispose() {
    _state.willUnmount();
    _updateStreamSubscription.cancel();
    _childNode._dispose();
    _state.dispose();
    super._dispose();
  }
}

abstract class FrameworkNode<T extends FrameworkWidget, U extends html.Element>
    extends Node<T> {
  final U _element;

  html.Animation? _animation;

  FrameworkNode(
    final T widget, {
    required final U element,
    final Node<Widget>? parentNode,
  })  : _element = element,
        super(widget, parentNode: parentNode);

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

  @override
  void _willWidgetUpdate(final T newWidget) {
    _disposeElement();
    super._willWidgetUpdate(newWidget);
  }

  @override
  void _didWidgetUpdate(final T oldWidget) {
    super._didWidgetUpdate(oldWidget);
    _initializeElement();
  }

  @override
  void _initialize() {
    super._initialize();

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
    super._dispose();
  }
}

class TextNode extends FrameworkNode<Text, html.SpanElement> {
  TextNode(
    final Text widget, {
    final Node<Widget>? parentNode,
  }) : super(widget, element: html.SpanElement(), parentNode: parentNode);

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
  ImageNode(
    final Image widget, {
    final Node<Widget>? parentNode,
  }) : super(widget, element: html.ImageElement(), parentNode: parentNode);

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
  late ChildNodes _childNodes;

  ContainerNode(
    final Container widget, {
    final Node<Widget>? parentNode,
  }) : super(widget, element: html.DivElement(), parentNode: parentNode);

  @override
  void _didWidgetUpdate(final Container oldWidget) {
    super._didWidgetUpdate(oldWidget);

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
              newChildNode.runtimeType == oldChildNode.runtimeType,
          sameTypeSearchStartIndex,
        );

        if (index > -1) {
          final newChildNode = newChildNodes[index];

          if (!oldChildNodes.contains(newChildNode)) {
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

    _childNodes = widget.children
        .map((final child) => _createNode(child, parentNode: this))
        .toList();

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
