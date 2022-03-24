import 'dart:async';
import 'dart:html' as html;

import 'package:dawn/src/node_creator.dart';
import 'package:dawn/src/widgets.dart';

import 'node.dart';

class StatefulNode extends Node<StatefulWidget> {
  late State state;
  late StreamSubscription<void> updateStreamSubscription;
  late Node childNode;

  StatefulNode(final StatefulWidget widget, {final Node? parentNode})
      : super(widget, parentNode: parentNode);

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

      childNode = createNode(
        newChildWidget,
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
  late T _widget;
  late Context _context;

  bool _isMounted = false;

  Context get context => _context;
  T get widget => _widget;
  bool get isMounted => _isMounted;

  void initialize() {}
  void didMount() => _isMounted = true;
  void willUnmount() {}
  void dispose() => _isMounted = false;
}

abstract class Store {
  final _updateController = StreamController<void>.broadcast();
  final _updateDebouncer = Debouncer();

  void setState(final void Function() callback) {
    callback();
    _updateDebouncer.enqueue(() => _updateController.add(null));
  }

  StreamSubscription<void> onUpdate(final void Function() callback) =>
      _updateController.stream.listen((final event) => callback());
}

class Debouncer {
  int? _animationFrame;

  void enqueue(final void Function() task) {
    if (_animationFrame != null) {
      html.window.cancelAnimationFrame(_animationFrame!);
    }

    _animationFrame =
        html.window.requestAnimationFrame((final highResTime) => task());
  }
}
