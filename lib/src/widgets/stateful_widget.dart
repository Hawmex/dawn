import 'dart:async';

import 'package:dawn/foundation.dart';

import 'widget.dart';

/// A widget that has a mutable state.
abstract class StatefulWidget extends Widget {
  /// Creates a new [StatefulWidget] that has a mutable state.
  const StatefulWidget({super.key});

  @override
  StatefulNode createNode() => StatefulNode(this);

  /// Creates the mutable state for this widget.
  State createState();
}

/// The logic and internal state for a [StatefulWidget].
abstract class State<T extends StatefulWidget> extends Store with Buildable {
  bool _isMounted = false;
  late T _widget;
  late final BuildContext _context;

  /// Whether this [State] is currently in the tree.
  bool get isMounted => _isMounted;

  /// The current configuration of this [State].
  T get widget => _widget;

  /// The location of this [State] in the tree.
  BuildContext get context => _context;

  /// Called after all child nodes are initialized.
  ///
  /// *Flowing upwards*
  void didMount() => _isMounted = true;

  /// Called after the configuration is updated.
  void didWidgetUpdate(final T oldWidget) {}

  /// Called after the dependencies are updated.
  void didDependenciesUpdate() {}

  /// Called before the removal of this [State] from the tree.
  ///
  /// *Flowing downwards*
  void willUnmount() => _isMounted = false;
}

class StatefulNode extends Node<StatefulWidget> {
  /// The child of this [Node] in the tree.
  late Node childNode;

  late final State _state;
  late final StreamSubscription<void> _updateStreamSubscription;

  StatefulNode(super.widget);

  @override
  void updateSubtree() {
    final newChildWidget = _state.build(context);

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
  void initialize() {
    super.initialize();

    _state = widget.createState()
      .._widget = widget
      .._context = context
      ..initialize();

    childNode = _state.build(context).createNode()
      ..parentNode = this
      ..initialize();

    _updateStreamSubscription = _state.listen(enqueueSubtreeUpdate);

    _state.didMount();
  }

  @override
  void didWidgetUpdate(final StatefulWidget oldWidget) {
    _state._widget = widget;
    super.didWidgetUpdate(oldWidget);
    _state.didWidgetUpdate(oldWidget);
  }

  @override
  void didDependenciesUpdate() {
    super.didDependenciesUpdate();
    _state.didDependenciesUpdate();
  }

  @override
  void dispose() {
    _state.willUnmount();
    _updateStreamSubscription.cancel();
    childNode.dispose();
    _state.dispose();
    super.dispose();
  }
}
