import 'dart:async';

import 'package:dawn/foundation.dart';

import 'inherited_widget.dart';

/// The base class for all of Dawn widgets.
///
/// **Notice:** Unlike Flutter, [key] is a [String] in Dawn.
abstract class Widget {
  final String? key;

  const Widget({this.key});

  /// Checks if two widgets match during a node tree update.
  ///
  /// - If the return value is `true`, the owner [Node] is updated.
  ///
  /// - If the return value is `false`, the owner [Node] is replaced by a new
  /// one.
  bool matches(final Widget otherWidget) =>
      runtimeType == otherWidget.runtimeType && key == otherWidget.key;

  /// Returns instantiation of this [Widget] at a particular location in the
  /// tree.
  Node createNode();
}

/// An instantiation of a [Widget] at a particular location in the tree.
abstract class Node<T extends Widget> {
  T _widget;
  bool _isActive = false;
  final _subtreeUpdateDebouncer = Debouncer();
  late final context = BuildContext(this);
  late final Node? parentNode;

  Node(this._widget);

  T get widget => _widget;

  /// If [widget] is updated while this [Node] is present in the tree,
  /// [willWidgetUpdate] and [didWidgetUpdate] are called.
  set widget(final T newWidget) {
    final oldWidget = widget;

    if (newWidget != oldWidget) {
      if (_isActive) willWidgetUpdate(newWidget);
      _widget = newWidget;
      if (_isActive) didWidgetUpdate(oldWidget);
    }
  }

  List<Node> get parentNodes =>
      parentNode == null ? [] : [parentNode!, ...parentNode!.parentNodes];

  /// Returns the closest parent [InheritedWidget] with the `runtimeType` equal
  /// to [U].
  ///
  /// Also, if [InheritedWidget] is updated, [didDependenciesUpdate] is called.
  U dependOnInheritedWidgetOfExactType<U extends InheritedWidget>() {
    final inheritedNode = parentNodes.firstWhere(
      (final parentNode) => parentNode.widget.runtimeType == U,
    ) as InheritedNode;

    late final StreamSubscription<void> subscription;

    subscription = inheritedNode.listen(() {
      subscription.cancel();
      if (_isActive) didDependenciesUpdate();
    });

    return inheritedNode.widget as U;
  }

  /// Debounces multiple calls to [updateSubtree].
  void enqueueSubtreeUpdate() {
    _subtreeUpdateDebouncer.enqueueTask(() {
      if (_isActive) updateSubtree();
    });
  }

  /// Called every time the [widget] or a dependency is updated.
  void updateSubtree();

  /// Called after this [Node] is added to the tree.
  ///
  /// *Flowing downwards*
  void initialize() => _isActive = true;

  /// Called before the [widget] is updated. Use this to dispose the previous
  /// [widget].
  void willWidgetUpdate(final T newWidget) {}

  /// Called after the [widget] is updated. Use this to initialize the new
  /// [widget] (add event listeners for example).
  void didWidgetUpdate(final T oldWidget) => enqueueSubtreeUpdate();

  /// Called after the dependencies are updated.
  void didDependenciesUpdate() => enqueueSubtreeUpdate();

  /// Called after this [Node] and all of its children are removed from the tree.
  ///
  /// *Flowing upwards*
  void dispose() => _isActive = false;
}
