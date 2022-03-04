import 'dart:async';
import 'dart:html';

import 'package:dawn/src/context.dart';
import 'package:dawn/src/debouncer.dart';
import 'package:dawn/src/state.dart';
import 'package:dawn/src/widgets.dart';

typedef ChildNodes = List<Node<Widget>>;

void runApp(final Widget app) {
  if (app is StatelessWidget) {
    StatelessNode(app)._initialize();
  } else if (app is StatefulWidget) {
    StatefulNode(app)._initialize();
  } else {
    throw TypeError();
  }
}

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

  bool _isInitialized = false;

  Node({final Node<Widget>? parentNode})
      : context = parentNode != null
            ? Context([parentNode, ...parentNode.context.sequence])
            : const Context.empty();

  bool get isInitialized => _isInitialized;

  void _initialize() => _isInitialized = true;
  void _dispose() => _isInitialized = false;
}

class StatelessNode extends Node<StatelessWidget> {
  @override
  final StatelessWidget widget;

  late final _childNode = _createNode(widget.build(context), parentNode: this);

  StatelessNode(this.widget, {final Node<Widget>? parentNode})
      : super(parentNode: parentNode);

  @override
  void _initialize() {
    super._initialize();
    _childNode._initialize();
  }

  @override
  void _dispose() {
    _childNode._dispose();
    super._dispose();
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
      _createNode(_state.build(context), parentNode: this);

  StatefulNode(this.widget, {final Node<Widget>? parentNode})
      : super(parentNode: parentNode);

  void _stateDidUpdate() {
    final oldChildNode = _childNode;
    final newChildNode = _createNode(_state.build(context), parentNode: this);

    if (newChildNode is FrameworkNode<FrameworkWidget, Element> &&
        oldChildNode is FrameworkNode<FrameworkWidget, Element> &&
        newChildNode.runtimeType == oldChildNode.runtimeType) {
      oldChildNode._setWidget(newChildNode.widget);
    } else if (newChildNode.widget != oldChildNode.widget) {
      oldChildNode._dispose();
      _childNode = newChildNode.._initialize();
    }
  }

  @override
  void _initialize() {
    super._initialize();
    _state.initialize();
    _childNode._initialize();
    _updateStreamSubscription = _state.onUpdate(_stateDidUpdate);
    _state.didMount();
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

abstract class FrameworkNode<T extends FrameworkWidget, U extends Element>
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

  void _setWidget(final T newWidget) {
    if (widget != newWidget) {
      _willWidgetChange();
      _widget = newWidget;
      _didWidgetChange();
    }
  }

  void _initializeElement() => _element
    ..setAttribute('style', widget.style.rulesString)
    ..addEventListener('pointerdown', widget.onPointerDown)
    ..addEventListener('pointerup', widget.onPointerUp)
    ..addEventListener('pointerenter', widget.onPointerEnter)
    ..addEventListener('pointerleave', widget.onPointerLeave)
    ..addEventListener('click', widget.onPress);

  void _disposeElement() => _element
    ..removeEventListener('pointerdown', widget.onPointerDown)
    ..removeEventListener('pointerup', widget.onPointerUp)
    ..removeEventListener('pointerenter', widget.onPointerEnter)
    ..removeEventListener('pointerleave', widget.onPointerLeave)
    ..removeEventListener('click', widget.onPress);

  void _willWidgetChange() => _disposeElement();
  void _didWidgetChange() => _initializeElement();

  @override
  void _initialize() {
    super._initialize();

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

class TextNode extends FrameworkNode<Text, SpanElement> {
  TextNode(final Text widget, {final Node<Widget>? parentNode})
      : super(widget, element: SpanElement(), parentNode: parentNode);

  @override
  void _initializeElement() {
    super._initializeElement();
    _element.text = widget.value;
  }
}

class ImageNode extends FrameworkNode<Image, ImageElement> {
  ImageNode(final Image widget, {final Node<Widget>? parentNode})
      : super(widget, element: ImageElement(), parentNode: parentNode);

  @override
  void _initializeElement() {
    super._initializeElement();
    _element.src = widget.source;
  }
}

class UserInputController {
  final _changeController = StreamController<String>.broadcast();
  final _inputController = StreamController<String>.broadcast();

  String _value = '';

  String get value => _value;

  StreamSubscription<String> onChange(
    final void Function(String value) callback,
  ) =>
      _changeController.stream.listen(callback);

  StreamSubscription<String> onInput(
    final void Function(String value) callback,
  ) =>
      _inputController.stream.listen(callback);
}

class InputNode extends FrameworkNode<Input, TextInputElement> {
  final _inputDebouncer = Debouncer();

  late final StreamSubscription<Event> _changeSubscription;
  late final StreamSubscription<Event> _inputSubscription;

  InputNode(final Input widget, {final Node<Widget>? parentNode})
      : super(widget, element: TextInputElement(), parentNode: parentNode);

  @override
  void _initializeElement() {
    super._initializeElement();
    _element.value = widget.controller.value;
  }

  @override
  void _initialize() {
    super._initialize();

    _changeSubscription = _element.onChange.listen((final event) {
      widget.controller._value = _element.value!;
      widget.controller._changeController.add(widget.controller.value);
    });

    _inputSubscription = _element.onInput.listen((final event) {
      widget.controller._value = _element.value!;

      _inputDebouncer.enqueue(
        () => widget.controller._inputController.add(widget.controller.value),
      );
    });
  }

  @override
  void _dispose() {
    _inputSubscription.cancel();
    _changeSubscription.cancel();
    super._dispose();
  }
}

class TextBoxNode extends FrameworkNode<TextBox, TextAreaElement> {
  final _inputDebouncer = Debouncer();

  late final StreamSubscription<Event> _changeSubscription;
  late final StreamSubscription<Event> _inputSubscription;

  TextBoxNode(final TextBox widget, {final Node<Widget>? parentNode})
      : super(widget, element: TextAreaElement(), parentNode: parentNode);

  @override
  void _initializeElement() {
    super._initializeElement();
    _element.value = widget.controller.value;
  }

  @override
  void _initialize() {
    super._initialize();

    _changeSubscription = _element.onChange.listen((final event) {
      widget.controller._value = _element.value!;
      widget.controller._changeController.add(widget.controller.value);
    });

    _inputSubscription = _element.onInput.listen((final event) {
      widget.controller._value = _element.value!;

      _inputDebouncer.enqueue(
        () => widget.controller._inputController.add(widget.controller.value),
      );
    });
  }

  @override
  void _dispose() {
    _inputSubscription.cancel();
    _changeSubscription.cancel();
    super._dispose();
  }
}

class ContainerNode extends FrameworkNode<Container, DivElement> {
  late ChildNodes _childNodes = widget.children
      .map((final child) => _createNode(child, parentNode: this))
      .toList();

  ContainerNode(final Container widget, {final Node<Widget>? parentNode})
      : super(widget, element: DivElement(), parentNode: parentNode);

  @override
  void _didWidgetChange() {
    super._didWidgetChange();

    final oldChildNodes = _childNodes;

    final newChildNodes = widget.children
        .map((final child) => _createNode(child, parentNode: this))
        .toList();

    int searchIndex = 0;

    for (final oldChildNode in oldChildNodes) {
      final index = newChildNodes.indexWhere(
        (final newChildNode) =>
            newChildNode.runtimeType == oldChildNode.runtimeType,
        searchIndex,
      );

      if (index < 0) {
        oldChildNode._dispose();
      } else {
        final newChildNode = newChildNodes[index];

        if (newChildNode.widget == oldChildNode.widget) {
          newChildNodes[index] = oldChildNode;
          searchIndex = index + 1;
        } else if (newChildNode is FrameworkNode<FrameworkWidget, Element> &&
            oldChildNode is FrameworkNode<FrameworkWidget, Element>) {
          oldChildNode._setWidget(newChildNode.widget);

          newChildNodes[index] = oldChildNode;
          searchIndex = index + 1;
        } else {
          oldChildNode._dispose();
        }
      }
    }

    _childNodes = newChildNodes;

    for (final childNode in _childNodes) {
      if (!childNode.isInitialized) childNode._initialize();
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
