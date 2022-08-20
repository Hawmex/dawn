import 'dart:async';

import 'package:dawn/foundation.dart';

import 'widget.dart';

abstract class StatefulWidget extends Widget {
  const StatefulWidget({super.key});

  @override
  StatefulNode createNode() => StatefulNode(this);

  State createState();
}

abstract class State<T extends StatefulWidget> extends Store with Buildable {
  bool _isMounted = false;
  late final BuildContext _context;
  late T _widget;

  bool get isMounted => _isMounted;
  BuildContext get context => _context;
  T get widget => _widget;

  void didMount() => _isMounted = true;
  void didWidgetUpdate(final T oldWidget) {}
  void didDependenciesUpdate() {}
  void willUnmount() => _isMounted = false;
}

class StatefulNode extends Node<StatefulWidget> {
  late final State _state;
  late Node childNode;
  late StreamSubscription<void> _updateStreamSubscription;

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
