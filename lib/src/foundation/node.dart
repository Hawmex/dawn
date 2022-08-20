import 'dart:async';

import 'package:dawn/widgets.dart';

import 'build_context.dart';
import 'debouncer.dart';

abstract class Node<T extends Widget> {
  T _widget;
  bool _isActive = false;
  late final context = BuildContext(this);
  late final _subtreeUpdateDebouncer = Debouncer();
  late final Node? parentNode;

  Node(this._widget);

  T get widget => _widget;

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

  void enqueueSubtreeUpdate() {
    _subtreeUpdateDebouncer.enqueueTask(() {
      if (_isActive) updateSubtree();
    });
  }

  U dependOnInheritedWidgetOfExactType<U extends InheritedWidget>() {
    final inheritedNode = parentNodes.firstWhere(
      (final parentNode) => parentNode.widget.runtimeType == U,
    ) as InheritedNode;

    late StreamSubscription<void> subscription;

    subscription = inheritedNode.listen(() {
      subscription.cancel();
      if (_isActive) didDependenciesUpdate();
    });

    return inheritedNode.widget as U;
  }

  void initialize() => _isActive = true;
  void willWidgetUpdate(final T newWidget) {}
  void didWidgetUpdate(final T oldWidget) => enqueueSubtreeUpdate();
  void didDependenciesUpdate() => enqueueSubtreeUpdate();
  void dispose() => _isActive = false;

  void updateSubtree();
}
