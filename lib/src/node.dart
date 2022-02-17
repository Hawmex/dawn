import 'dart:async';
import 'dart:html';

import 'package:dawn/src/context.dart';
import 'package:dawn/src/widgets.dart';

class Node {
  late final StreamSubscription<void>? _updateListener;

  final Widget widget;
  final Context context;
  final State<StatefulWidget>? _state;
  final Element? _element;

  final List<Node> _childNodes = [];

  bool _isActive = false;

  Node({
    required this.widget,
    final Node? parentNode,
  })  : context = Context(
          parentNode == null
              ? []
              : [parentNode, ...parentNode.context.sequence],
        ),
        _state = widget is StatefulWidget ? widget.createState() : null,
        _element = widget is Text
            ? SpanElement()
            : widget is Container
                ? DivElement()
                : null {
    _setupState();
    _setupElement();
  }

  void _setupState() {
    _state
      ?..widget = widget as StatefulWidget
      ..context = context;
  }

  void _setupElement() {
    _element
      ?..setAttribute('style', (widget as FrameworkWidget).styles.rules)
      ..addEventListener(
        'pointerdown',
        (final event) {
          (widget as FrameworkWidget)
              .onPointerDown
              ?.forEach((final handler) => handler(event));
        },
      )
      ..addEventListener(
        'pointerup',
        (final event) {
          (widget as FrameworkWidget)
              .onPointerUp
              ?.forEach((final handler) => handler(event));
        },
      )
      ..addEventListener(
        'pointerenter',
        (final event) {
          (widget as FrameworkWidget)
              .onPointerEnter
              ?.forEach((final handler) => handler(event));
        },
      )
      ..addEventListener(
        'pointerleave',
        (final event) {
          (widget as FrameworkWidget)
              .onPointerLeave
              ?.forEach((final handler) => handler(event));
        },
      )
      ..addEventListener(
        'click',
        (final event) {
          (widget as FrameworkWidget)
              .onPress
              ?.forEach((final handler) => handler(event));
        },
      );

    if (_element is SpanElement) {
      _element!.text = (widget as Text).value;
    }
  }

  void _appendChildNode(final Node childNode) {
    if (childNode._element != null) {
      final contextWithSelf = [this, ...context.sequence];

      if (contextWithSelf.any((final node) => node.widget is Container)) {
        contextWithSelf
            .firstWhere((final node) => node.widget is Container)
            ._element!
            .append(childNode._element!);
      } else {
        document.body!.append(childNode._element!);
      }
    }
  }

  void _updateText({
    required final Node oldNode,
    required final Node newNode,
  }) {
    oldNode._element!.setAttribute(
      'style',
      (newNode.widget as Text).styles.rules,
    );

    oldNode._element!.text = (newNode.widget as Text).value;
  }

  void _updateContainer({
    required final Node oldNode,
    required final Node newNode,
  }) {
    final oldChildNodes = oldNode._childNodes;

    final newChildNodes = (newNode.widget as Container)
        .children
        .map((final child) => Node(widget: child, parentNode: newNode))
        .toList();

    int searchIndex = 0;

    oldNode._element!.setAttribute(
      'style',
      (newNode.widget as Container).styles.rules,
    );

    for (final oldChildNode in oldChildNodes) {
      final index = newChildNodes.indexWhere(
        (final newChildNode) =>
            newChildNode.widget.runtimeType == oldChildNode.widget.runtimeType,
        searchIndex,
      );

      if (index < 0) {
        oldChildNode.dispose();
        oldChildNode._element!.remove();
      } else {
        final newChildNode = newChildNodes[index];

        searchIndex = index + 1;

        if (oldChildNode.widget is Container ||
            oldChildNode.widget is Text ||
            newChildNode.widget == oldChildNode.widget) {
          if (oldChildNode.widget is Container) {
            _updateContainer(
              oldNode: oldChildNode,
              newNode: newChildNodes[index],
            );
          } else if (oldChildNode.widget is Text) {
            _updateText(oldNode: oldChildNode, newNode: newChildNodes[index]);
          }

          newChildNodes[index] = oldChildNode;
        }
      }
    }

    oldChildNodes.clear();
    oldChildNodes.addAll(newChildNodes);

    for (final childNode in oldChildNodes) {
      if (!childNode._isActive) {
        if (childNode._element != null) {
          final index = oldChildNodes.indexOf(childNode);

          if (oldNode._element!.children.length <= index) {
            oldNode._element!.append(childNode._element!);
          } else {
            oldNode._element!.insertBefore(
              childNode._element!,
              oldNode._element!.children[index],
            );
          }
        }

        childNode.initialize();
      }
    }
  }

  void _stateDidUpdate() {
    final oldChildNode = _childNodes.single;
    final newChildNode = Node(widget: _state!.build(context), parentNode: this);

    if (newChildNode.widget is Container && oldChildNode.widget is Container) {
      _updateContainer(oldNode: oldChildNode, newNode: newChildNode);
    } else if (newChildNode.widget is Text && oldChildNode.widget is Text) {
      _updateText(oldNode: oldChildNode, newNode: newChildNode);
    } else if (newChildNode.widget != oldChildNode.widget) {
      oldChildNode.dispose();
      oldChildNode._element?.remove();
      _childNodes[0] = newChildNode;
      _appendChildNode(newChildNode);
      newChildNode.initialize();
    }
  }

  void _initializeChildNodes() {
    if (widget is StatelessWidget) {
      _childNodes.add(
        Node(
          widget: (widget as StatelessWidget).build(context),
          parentNode: this,
        ),
      );
    } else if (_state != null) {
      _childNodes.add(Node(widget: _state!.build(context), parentNode: this));
    } else if (widget is Container) {
      _childNodes.addAll((widget as Container)
          .children
          .map((final child) => Node(widget: child, parentNode: this)));
    }

    for (final childNode in _childNodes) {
      _appendChildNode(childNode);
      childNode.initialize();
    }
  }

  void _disposeChildNodes() {
    for (final childNode in _childNodes) {
      childNode.dispose();
      childNode._element?.remove();
    }

    _childNodes.clear();
  }

  void initialize() {
    _isActive = true;
    _state?.initialize();
    _initializeChildNodes();

    _updateListener =
        _state?.updateStream.listen((final event) => _stateDidUpdate());

    _state?.didMount();
  }

  void dispose() {
    _state?.willUnmount();
    _updateListener?.cancel();
    _disposeChildNodes();
    _state?.dispose();
    _isActive = false;
  }
}
