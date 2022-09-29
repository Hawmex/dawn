import 'dart:async';

import 'package:dawn/core.dart';

import 'widget.dart';

abstract class StatefulWidget extends Widget {
  const StatefulWidget({super.key});

  State createState();

  @override
  StatefulNode createNode() => StatefulNode(this);
}

abstract class State<T extends StatefulWidget> extends Store with Buildable {
  bool _isMounted = false;
  late T _widget;
  late final BuildContext _context;

  bool get isMounted => _isMounted;
  T get widget => _widget;
  BuildContext get context => _context;

  void didMount() => _isMounted = true;
  void widgetDidUpdate(final T oldWidget) {}
  void dependenciesDidUpdate() {}
  void willUnmount() => _isMounted = false;
}

class StatefulNode<T extends StatefulWidget> extends SingleChildNode<T> {
  late final State<T> _state;
  late final StreamSubscription<void> _updateStreamSubscription;

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
