import 'dart:async';
import 'dart:html' as html;

import 'package:dawn/src/node_creator.dart';
import 'package:dawn/src/nodes.dart';
import 'package:dawn/src/widgets.dart';

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

/// A base class for storing data and subscribing to it.
///
/// It can be used to implement complex state management solutions in patterns
/// similar to `Provider`.
abstract class Store {
  final _updateController = StreamController<void>.broadcast();
  final _updateDebouncer = Debouncer();

  /// Runs the [callback] and debounces a call to [onUpdate].
  void setState(final void Function() callback) {
    callback();
    _updateDebouncer.enqueue(() => _updateController.add(null));
  }

  /// [callback] is called after [setState] has been called.
  StreamSubscription<void> onUpdate(final void Function() callback) =>
      _updateController.stream.listen((final event) => callback());
}

/// A class to debounce heavy tasks like rebuilding Dawn widgets.
///
/// [Debouncer] uses `requestAnimationFrame` API under the hood.
class Debouncer {
  int? _animationFrame;

  /// Add a new task to the execution queue.
  ///
  /// ```dart
  /// Debouncer()
  ///   ..enqueue(() => print('Hello World!'))
  ///   ..enqueue(() => print('Hello World!'));
  /// ```
  ///
  /// `Hello World!` will be printed once.
  void enqueue(final void Function() task) {
    if (_animationFrame != null) {
      html.window.cancelAnimationFrame(_animationFrame!);
    }

    _animationFrame =
        html.window.requestAnimationFrame((final highResTime) => task());
  }
}
