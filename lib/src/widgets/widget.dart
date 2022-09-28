import 'dart:async';

import 'package:dawn/core.dart';

import 'inherited_widget.dart';

abstract class Widget {
  final String? key;

  const Widget({this.key});

  Node createNode();

  bool matches(final Widget otherWidget) =>
      runtimeType == otherWidget.runtimeType && key == otherWidget.key;
}

abstract class Node<T extends Widget> {
  bool _isActive = false;
  T _widget;

  late final context = BuildContext(this);
  late final Node? parentNode;

  Node(this._widget);

  List<Node> get parentNodes =>
      parentNode == null ? [] : [parentNode!, ...parentNode!.parentNodes];

  T get widget => _widget;

  set widget(final T newWidget) {
    final oldWidget = widget;

    if (newWidget != oldWidget) {
      if (_isActive) widgetWillUpdate(newWidget);
      _widget = newWidget;
      if (_isActive) widgetDidUpdate(oldWidget);
    }
  }

  U dependOnInheritedWidgetOfExactType<U extends InheritedWidget>() {
    final inheritedNode = parentNodes.firstWhere(
      (final parentNode) => parentNode.widget.runtimeType == U,
    ) as InheritedNode;

    late final StreamSubscription<void> subscription;

    subscription = inheritedNode.listen(() {
      subscription.cancel();
      if (_isActive) dependenciesDidUpdate();
    });

    return inheritedNode.widget as U;
  }

  void initialize() => _isActive = true;
  void widgetWillUpdate(final T newWidget) {}
  void widgetDidUpdate(final T oldWidget) {}
  void dependenciesDidUpdate() {}
  void dispose() => _isActive = false;
}

mixin ReassemblableNode<T extends Widget> on Node<T> {
  void reassemble();

  @override
  void widgetDidUpdate(final T oldWidget) {
    super.widgetDidUpdate(oldWidget);
    reassemble();
  }

  @override
  void dependenciesDidUpdate() {
    super.dependenciesDidUpdate();
    reassemble();
  }
}

abstract class SingleChildNode<T extends Widget> extends Node<T>
    with ReassemblableNode<T> {
  late Node childNode;

  SingleChildNode(super.widget);

  Widget get newChildWidget;

  @override
  void initialize() {
    super.initialize();

    childNode = newChildWidget.createNode()
      ..parentNode = this
      ..initialize();
  }

  @override
  void reassemble() {
    if (newChildWidget.matches(childNode.widget)) {
      childNode.widget = newChildWidget;
    } else {
      childNode.dispose();

      childNode = newChildWidget.createNode()
        ..parentNode = this
        ..initialize();
    }
  }

  @override
  void dispose() {
    childNode.dispose();
    super.dispose();
  }
}

abstract class MultiChildNode<T extends Widget> extends Node<T>
    with ReassemblableNode<T> {
  late List<Node> childNodes;

  MultiChildNode(super.widget);

  List<Widget> get newChildWidgets;

  @override
  void initialize() {
    super.initialize();

    childNodes = [
      for (final newChildWidget in newChildWidgets)
        newChildWidget.createNode()
          ..parentNode = this
          ..initialize()
    ];
  }

  @override
  void reassemble() {
    final oldChildNodes = childNodes;

    final newChildNodes = newChildWidgets
        .map((final newChildWidget) => newChildWidget.createNode())
        .toList();

    int exactWidgetsSearchStartIndex = 0;
    int matchingWidgetsSearchStartIndex = 0;

    for (final oldChildNode in oldChildNodes) {
      final index = newChildNodes.indexWhere(
        (final newChildNode) => newChildNode.widget == oldChildNode.widget,
        exactWidgetsSearchStartIndex,
      );

      if (index > -1) {
        newChildNodes[index] = oldChildNode;
        exactWidgetsSearchStartIndex = index + 1;
      }
    }

    for (final oldChildNode in oldChildNodes) {
      if (!newChildNodes.contains(oldChildNode)) {
        final index = newChildNodes.indexWhere(
          (final newChildNode) =>
              !oldChildNodes.contains(newChildNode) &&
              newChildNode.widget.matches(oldChildNode.widget),
          matchingWidgetsSearchStartIndex,
        );

        if (index > -1) {
          final newChildNode = newChildNodes[index];

          oldChildNode.widget = newChildNode.widget;
          newChildNodes[index] = oldChildNode;
          matchingWidgetsSearchStartIndex = index + 1;
        }
      }
    }

    for (final childNode in childNodes) {
      if (!newChildNodes.contains(childNode)) childNode.dispose();
    }

    childNodes = newChildNodes;

    for (final childNode in childNodes) {
      if (!oldChildNodes.contains(childNode)) {
        childNode
          ..parentNode = this
          ..initialize();
      }
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
