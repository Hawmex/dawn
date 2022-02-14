import 'dart:async';

import 'package:dawn/src/core/components.dart';

class Context {
  final List<Component> _sequence;

  const Context(this._sequence);

  T getParentOfExactType<T extends Component>() {
    return _sequence.firstWhere(
      (final component) => component.runtimeType == T,
    ) as T;
  }
}

class Node {
  final Component _component;
  final Node? _parentNode;
  final _childNodes = <Node>[];
  StreamSubscription<void>? _updateSubscription;

  Node(this._component, [this._parentNode]);

  Context get context {
    if (_parentNode == null) {
      return const Context([]);
    } else {
      return Context([
        _parentNode!._component,
        ..._parentNode!.context._sequence,
      ]);
    }
  }

  void _initializeComponent() {
    final component = _component;
    if (component is StatefulComponent) component.initialize();
  }

  void _disposeComponent() {
    final component = _component;
    if (component is StatefulComponent) component.dispose();
  }

  void _addAllChildNodes() {
    final component = _component;

    if (component is Renderable) {
      final childComponents = component.render(context);

      final childNodes = childComponents.map(
        (final childComponent) => Node(childComponent, this),
      );

      _childNodes.addAll(childNodes);
    }
  }

  void _clearChildNodes() => _childNodes.clear();

  void _initializeChildNodes() {
    for (final childNode in _childNodes) {
      childNode.initialize();
    }
  }

  void _disposeChildNodes() {
    for (final childNode in _childNodes) {
      childNode.dispose();
    }
  }

  void _componentDidMount() {
    final component = _component;

    if (component is StatefulComponent) {
      final stream = component.updateStream;
      _updateSubscription = stream.listen((final _) => _componentDidUpdate());
      component.didMount();
    }
  }

  void _componentWillUnmount() {
    final component = _component;

    if (component is StatefulComponent) {
      component.willUnmount();
      if (_updateSubscription != null) _updateSubscription!.cancel();
    }
  }

  void _componentDidUpdate() {
    dispose();
    initialize();
  }

  void initialize() {
    _initializeComponent();
    _addAllChildNodes();
    _initializeChildNodes();
    _componentDidMount();
  }

  void dispose() {
    _componentWillUnmount();
    _disposeChildNodes();
    _clearChildNodes();
    _disposeComponent();
  }
}
