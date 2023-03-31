import 'dart:async';
import 'dart:html' as html;

import 'package:dawn/core.dart';

import 'inherited_widget.dart';
import 'painted_widget.dart';
import 'stateful_widget.dart';

/// The base class for all of Dawn's widgets.
///
/// **Notice:** Unlike Flutter, [key] is a [String] in Dawn.
abstract class Widget {
  final String? key;
  final Ref? ref;

  const Widget({this.key, this.ref});

  /// Returns a [Node] corresponding to this [Widget] at a particular location
  /// in the [Node] tree.
  Node createNode();

  /// Checks if two widgets match during a [ReassemblableNode] reassembly.
  ///
  /// - If the return value is `true`, the child [Node] is updated.
  ///
  /// - If the return value is `false`, the child [Node] is replaced by a new
  ///   one.
  bool matches(final Widget otherWidget) =>
      runtimeType == otherWidget.runtimeType && key == otherWidget.key;
}

/// Similar to ref in React and GlobalKey in Flutter.
class Ref {
  Node? _currentNode;

  /// Creates a new instance of [Ref].
  Ref();

  /// The [Widget] in the tree that has this [Ref].
  Widget? get currentWidget => _currentNode?.widget;

  /// The [State] of the [Widget] in the tree that has this [Ref].
  State? get currentState {
    if (_currentNode is StatefulNode) {
      return (_currentNode as StatefulNode).state;
    } else {
      return null;
    }
  }

  /// The [html.Element] of the [Widget] in the tree that has this [Ref].
  html.Element? get currentElement {
    if (_currentNode is PaintedNode) {
      return (_currentNode as PaintedNode).element;
    } else {
      return null;
    }
  }

  /// The [BuildContext] of the [Widget] in the tree that has this [Ref].
  BuildContext? get currentContext => _currentNode?.context;
}

/// An instantiation of a [Widget] at a particular location in the [Node] tree.
abstract class Node<T extends Widget> {
  bool _isActive = false;
  T _widget;

  late final _dependencySubscriptions = <StreamSubscription<void>>{};
  late final context = BuildContext(this);
  late final Node? parentNode;

  Node(this._widget);

  List<Node> get parentNodes =>
      parentNode == null ? [] : [parentNode!, ...parentNode!.parentNodes];

  T get widget => _widget;

  /// If [widget] is updated while this [Node] is present in the [Node] tree,
  /// [widgetWillUpdate] and [widgetDidUpdate] are called.
  set widget(final T newWidget) {
    final oldWidget = widget;

    if (newWidget != oldWidget) {
      widgetWillUpdate(newWidget);
      _widget = newWidget;
      widgetDidUpdate(oldWidget);
    }
  }

  /// Returns the nearest parent [InheritedWidget] with the exact type [U].
  ///
  /// Also, if [U] is updated, [dependenciesDidUpdate] is called.
  U dependOnInheritedWidgetOfExactType<U extends InheritedWidget>() {
    final inheritedNode = parentNodes.firstWhere(
      (final parentNode) => parentNode.widget.runtimeType == U,
    ) as InheritedNode;

    late final StreamSubscription<void> subscription;

    subscription = inheritedNode.listen(() {
      subscription.cancel();
      dependenciesDidUpdate();
    });

    _dependencySubscriptions.add(subscription);

    return inheritedNode.widget as U;
  }

  /// Called after this [Node] is added to the [Node] tree.
  ///
  /// *Flowing downwards*
  void initialize() {
    widget.ref?._currentNode = this;

    _isActive = true;
  }

  /// Called before the [widget] is updated. Use this to remove references to
  /// the previous widget.
  void widgetWillUpdate(final T newWidget) {
    widget.ref?._currentNode = null;
  }

  /// Called after the [widget] is updated. Use this to initialize the new
  /// [widget].
  void widgetDidUpdate(final T oldWidget) {
    widget.ref?._currentNode = this;
  }

  /// Called after the dependencies are updated.
  void dependenciesDidUpdate() {}

  /// Called after this [Node] is completely removed from the [Node] tree.
  ///
  /// *Flowing upwards*
  void dispose() {
    _isActive = false;

    widget.ref?._currentNode = null;

    for (final dependencySubscription in _dependencySubscriptions) {
      dependencySubscription.cancel();
    }

    _dependencySubscriptions.clear();
  }
}

/// A [Node] with a child or multiple children in the [Node] tree.
mixin ReassemblableNode<T extends Widget> on Node<T> {
  final _reassemblyDebouncer = Debouncer();

  /// Updates or replaces this [ReassemblableNode]'s children.
  void reassemble();

  /// Debounces multiple calls to [reassemble].
  void enqueueReassembly() {
    _reassemblyDebouncer.enqueueTask(() {
      if (_isActive) reassemble();
    });
  }

  @override
  void widgetDidUpdate(final T oldWidget) {
    super.widgetDidUpdate(oldWidget);
    enqueueReassembly();
  }

  @override
  void dependenciesDidUpdate() {
    super.dependenciesDidUpdate();
    enqueueReassembly();
  }
}

/// A [ReassemblableNode] with only one child in the [Node] tree.
abstract class SingleChildNode<T extends Widget> extends Node<T>
    with ReassemblableNode<T> {
  late Node childNode;

  SingleChildNode(super.widget);

  Widget get childWidget;

  @override
  void initialize() {
    super.initialize();

    childNode = childWidget.createNode()
      ..parentNode = this
      ..initialize();
  }

  @override
  void reassemble() {
    if (childWidget.matches(childNode.widget)) {
      childNode.widget = childWidget;
    } else {
      childNode.dispose();

      childNode = childWidget.createNode()
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

/// A [ReassemblableNode] with multiple children in the [Node] tree.
abstract class MultiChildNode<T extends Widget> extends Node<T>
    with ReassemblableNode<T> {
  late List<Node> childNodes;

  MultiChildNode(super.widget);

  List<Widget> get childWidgets;

  List<Widget> get _sanitizedChildWidgets {
    final explicitKeys = childWidgets
        .map((final childWidget) => childWidget.key)
        .toList()
      ..removeWhere((final key) => key == null);

    final uniqueExplicitKeys = explicitKeys.toSet();

    if (explicitKeys.length != uniqueExplicitKeys.length) {
      throw StateError(
        "Unique explicit keys must be provided to each MultiChildNode",
      );
    } else {
      return childWidgets;
    }
  }

  @override
  void initialize() {
    super.initialize();

    childNodes = _sanitizedChildWidgets
        .map((final childWidget) => childWidget.createNode())
        .toList();

    for (final childNode in childNodes) {
      childNode
        ..parentNode = this
        ..initialize();
    }
  }

  @override
  void reassemble() {
    final oldChildNodes = childNodes;

    final newChildNodes = _sanitizedChildWidgets
        .map((final childWidget) => childWidget.createNode())
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
