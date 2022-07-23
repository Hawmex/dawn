import 'dart:async';

import 'package:dawn/foundation.dart';
import 'package:dawn/widgets.dart';

import 'node.dart';

class StatefulNode extends Node<StatefulWidget> {
  late State state;
  late Node childNode;
  late StreamSubscription<void> updateStreamSubscription;

  StatefulNode({required super.widget, super.parentNode});

  @override
  void initialize() {
    super.initialize();

    state = widget.createState()
      .._widget = widget
      .._context = context
      ..initialize();

    childNode = Node.create(
      widget: state.build(context),
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

      childNode = Node.create(
        widget: newChildWidget,
        parentNode: this,
      )..initialize();
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

abstract class State<T extends StatefulWidget> extends Store with Buildable {
  bool _isMounted = false;

  late T _widget;
  late BuildContext _context;

  bool get isMounted => _isMounted;
  T get widget => _widget;
  BuildContext get context => _context;

  void didMount() => _isMounted = true;
  void willUnmount() {}

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }
}
