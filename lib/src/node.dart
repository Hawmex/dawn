import 'dart:async';
import 'dart:html';

import 'package:dawn/src/context.dart';
import 'package:dawn/src/widgets.dart';

class Node {
  late final StreamSubscription<void>? _updateListener;

  final Context context;
  final State<StatefulWidget>? _state;
  final Element? _element;

  final List<Node> _childNodes = [];

  Widget _widget;

  bool _isActive = false;

  Node({
    required final Widget widget,
    final Node? parentNode,
  })  : _widget = widget,
        context = Context([
          if (parentNode != null) ...[
            parentNode,
            ...parentNode.context.sequence
          ]
        ]),
        _state = widget is StatefulWidget ? widget.createState() : null,
        _element = widget is Text
            ? SpanElement()
            : widget is Container
                ? DivElement()
                : null {
    _setupState();
    _setupElement();
  }

  Widget get widget => _widget;

  void _setupState() {
    _state
      ?..widget = _widget as StatefulWidget
      ..context = context;
  }

  void _setupElement() {
    _element
      ?..setAttribute('style', (_widget as FrameworkWidget).styles.rules)
      ..addEventListener(
        'pointerdown',
        (final event) {
          (_widget as FrameworkWidget)
              .onPointerDown
              ?.forEach((final handler) => handler(event));
        },
      )
      ..addEventListener(
        'pointerup',
        (final event) {
          (_widget as FrameworkWidget)
              .onPointerUp
              ?.forEach((final handler) => handler(event));
        },
      )
      ..addEventListener(
        'pointerenter',
        (final event) {
          (_widget as FrameworkWidget)
              .onPointerEnter
              ?.forEach((final handler) => handler(event));
        },
      )
      ..addEventListener(
        'pointerleave',
        (final event) {
          (_widget as FrameworkWidget)
              .onPointerLeave
              ?.forEach((final handler) => handler(event));
        },
      )
      ..addEventListener(
        'click',
        (final event) {
          (_widget as FrameworkWidget)
              .onPress
              ?.forEach((final handler) => handler(event));
        },
      );

    if (_element is SpanElement) {
      _element!.text = (_widget as Text).value;
    }
  }

  void _appendChildNode(final Node childNode) {
    if (childNode._element != null) {
      final contextWithSelf = [this, ...context.sequence];

      if (contextWithSelf.any((final node) => node._widget is Container)) {
        contextWithSelf
            .firstWhere((final node) => node._widget is Container)
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
    oldNode._widget = newNode._widget;

    oldNode._element!.setAttribute(
      'style',
      (newNode._widget as Text).styles.rules,
    );

    oldNode._element!.text = (newNode._widget as Text).value;
  }

  void _updateContainer({
    required final Node oldNode,
    required final Node newNode,
  }) {
    final oldChildNodes = oldNode._childNodes;

    final newChildNodes = (newNode._widget as Container)
        .children
        .map((final child) => Node(widget: child, parentNode: newNode))
        .toList();

    int searchIndex = 0;

    oldNode._element!.setAttribute(
      'style',
      (newNode._widget as Container).styles.rules,
    );

    for (final oldChildNode in oldChildNodes) {
      final index = newChildNodes.indexWhere(
        (final newChildNode) =>
            newChildNode._widget.runtimeType ==
            oldChildNode._widget.runtimeType,
        searchIndex,
      );

      if (index < 0) {
        oldChildNode.dispose();
        oldChildNode._element!.remove();
      } else {
        final newChildNode = newChildNodes[index];

        searchIndex = index + 1;

        if (oldChildNode._widget is Container ||
            oldChildNode._widget is Text ||
            newChildNode._widget == oldChildNode._widget) {
          if (oldChildNode._widget is Container) {
            _updateContainer(
              oldNode: oldChildNode,
              newNode: newChildNodes[index],
            );
          } else if (oldChildNode._widget is Text) {
            _updateText(oldNode: oldChildNode, newNode: newChildNodes[index]);
          }

          oldChildNode._widget = newChildNode._widget;
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

    if (newChildNode._widget is Container &&
        oldChildNode._widget is Container) {
      _updateContainer(oldNode: oldChildNode, newNode: newChildNode);
    } else if (newChildNode._widget is Text && oldChildNode._widget is Text) {
      _updateText(oldNode: oldChildNode, newNode: newChildNode);
    } else if (newChildNode._widget != oldChildNode._widget) {
      oldChildNode.dispose();
      oldChildNode._element?.remove();
      _childNodes[0] = newChildNode;
      _appendChildNode(newChildNode);
      newChildNode.initialize();
    }
  }

  void _initializeChildNodes() {
    if (_widget is StatelessWidget) {
      _childNodes.add(
        Node(
          widget: (_widget as StatelessWidget).build(context),
          parentNode: this,
        ),
      );
    } else if (_state != null) {
      _childNodes.add(Node(widget: _state!.build(context), parentNode: this));
    } else if (_widget is Container) {
      _childNodes.addAll((_widget as Container)
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
