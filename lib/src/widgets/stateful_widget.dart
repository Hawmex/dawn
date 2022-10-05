import 'dart:async';

import 'package:dawn/core.dart';

import 'widget.dart';

/// A [Widget] that has a mutable state.
abstract class StatefulWidget extends Widget {
  const StatefulWidget({super.key});

  /// Creates the mutable state for this widget.
  State createState();

  @override
  StatefulNode createNode() => StatefulNode(this);
}

/// The logic and internal state for a [StatefulWidget].
abstract class State<T extends StatefulWidget> extends Store with Buildable {
  bool _isMounted = false;
  late T _widget;
  late final BuildContext _context;

  /// Whether this [State] is currently in the [Node] tree.
  bool get isMounted => _isMounted;

  /// The current configuration of this [State].
  T get widget => _widget;

  /// The location of this [State] in the [Node] tree.
  BuildContext get context => _context;

  /// Called after all child nodes are initialized.
  ///
  /// *Flowing upwards*
  void didMount() => _isMounted = true;

  /// Called after the configuration is updated.
  void widgetDidUpdate(final T oldWidget) {}

  /// Called after the dependencies are updated.
  void dependenciesDidUpdate() {}

  /// Called before the removal of this [State] from the tree.
  ///
  /// *Flowing downwards*
  void willUnmount() => _isMounted = false;
}

/// A [Node] corresponding to [StatefulWidget].
class StatefulNode<T extends StatefulWidget> extends SingleChildNode<T> {
  late final State<T> _state;
  late final StreamSubscription<void> _updateStreamSubscription;

  /// Creates a new instance of [StatefulNode].
  StatefulNode(super.widget);

  @override
  Widget get childWidget => _state.build(context);

  @override
  void initialize() {
    _state = widget.createState() as State<T>
      .._widget = widget
      .._context = context
      ..initialize();

    super.initialize();

    _updateStreamSubscription = _state.listen(enqueueReassembly);
    _state.didMount();
  }

  @override
  void widgetDidUpdate(final T oldWidget) {
    _state._widget = widget;
    super.widgetDidUpdate(oldWidget);
    _state.widgetDidUpdate(oldWidget);
  }

  @override
  void dependenciesDidUpdate() {
    super.dependenciesDidUpdate();
    _state.dependenciesDidUpdate();
  }

  @override
  void dispose() {
    _state.willUnmount();
    _updateStreamSubscription.cancel();
    super.dispose();
    _state.dispose();
  }
}
