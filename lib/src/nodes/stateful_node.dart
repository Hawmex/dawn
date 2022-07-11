import 'dart:async';

import 'package:dawn/src/node_creator.dart';
import 'package:dawn/src/nodes/node.dart';
import 'package:dawn/src/utils/buildable.dart';
import 'package:dawn/src/utils/context.dart';
import 'package:dawn/src/utils/store.dart';
import 'package:dawn/src/widgets/stateful_widget.dart';

class StatefulNode extends Node<StatefulWidget> {
  late State state;
  late StreamSubscription<void> updateStreamSubscription;
  late Node childNode;

  StatefulNode(super.widget, {super.parentNode});

  @override
  void initialize() {
    super.initialize();

    state = widget.createState()
      .._widget = widget
      .._context = context
      ..initialize();

    childNode = createNode(
      state.build(context),
      parentNode: this,
    )..initialize();

    updateStreamSubscription = state.onUpdate(stateDidUpdate);

    state.didMount();
  }

  void stateDidUpdate() {
    final newChildWidget = state.build(context);

    if (childNode.widget.runtimeType == newChildWidget.runtimeType &&
        childNode.widget.key == newChildWidget.key) {
      childNode.widget = newChildWidget;
    } else {
      childNode.dispose();
      childNode = createNode(newChildWidget, parentNode: this)..initialize();
    }
  }

  @override
  void didWidgetUpdate(final StatefulWidget oldWidget) {
    super.didWidgetUpdate(oldWidget);
    state._widget = widget;
    stateDidUpdate();
  }

  @override
  void dispose() {
    state.willUnmount();
    updateStreamSubscription.cancel();
    childNode.dispose();
    state.dispose();
    super.dispose();
  }
}

/// The base class for the state of [StatefulWidget].
abstract class State<T extends StatefulWidget> extends Store with Buildable {
  late T _widget;
  late Context _context;

  bool _isMounted = false;

  Context get context => _context;

  /// Gets the current [widget] to which the state is attached to.
  T get widget => _widget;

  bool get isMounted => _isMounted;

  /// Called when the [widget] is added to the node tree (top to bottom).
  void initialize() {}

  /// Called when the [widget]'s subtree is completely added to the node tree
  /// (bottom to top).
  void didMount() => _isMounted = true;

  /// Called when the [widget] is going to be removed from the node tree
  /// (top to bottom).
  void willUnmount() {}

  /// Called when the [widget]'s subtree is completely removed from the node
  /// tree (bottom to top).
  void dispose() => _isMounted = false;
}
