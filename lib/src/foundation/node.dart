import 'dart:async';

import 'package:dawn/widgets.dart';

import 'build_context.dart';
import 'debouncer.dart';

abstract class Node<T extends Widget> {
  T _widget;
  bool _isActive = false;
  late final context = BuildContext(this);
  late final _dependencies = <StreamSubscription<void>>[];
  late final _subtreeUpdateDebouncer = Debouncer();
  late final Node? parentNode;

  Node(this._widget);

  T get widget => _widget;

  set widget(final T newWidget) {
    final oldWidget = widget;

    if (newWidget != oldWidget) {
      willWidgetUpdate(newWidget);
      _widget = newWidget;
      didWidgetUpdate(oldWidget);
    }
  }

  List<Node> get parentNodes =>
      parentNode == null ? [] : [parentNode!, ...parentNode!.parentNodes];

  U dependOnInheritedWidgetOfExactType<U extends InheritedWidget>() {
    final inheritedNode = parentNodes.firstWhere(
      (final parentNode) => parentNode.widget.runtimeType == U,
    ) as InheritedNode;

    _dependencies.add(inheritedNode.listen(didDependenciesUpdate));

    return inheritedNode.widget as U;
  }

  void initialize() => _isActive = true;

  void willWidgetUpdate(final T newWidget) {}

  void didWidgetUpdate(final T oldWidget) {
    _subtreeUpdateDebouncer.enqueueTask(() {
      if (_isActive) updateSubtree();
    });
  }

  void didDependenciesUpdate() {
    _subtreeUpdateDebouncer.enqueueTask(() {
      if (_isActive) updateSubtree();
    });
  }

  void dispose() {
    for (final dependency in _dependencies) {
      dependency.cancel();
    }

    _isActive = false;
  }

  void updateSubtree();
}
