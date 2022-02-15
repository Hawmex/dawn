import 'dart:async';

import 'package:dawn/src/core/components.dart';
import 'package:dawn/src/core/context.dart';

class Node {
  late final StreamSubscription<void>? _updateSubscription;

  final Component _component;
  final Context _context;
  final State<StatefulComponent>? _state;

  final _childNodes = <Node>[];

  Node(this._component, [final Node? parentNode])
      : _context = Context(
          parentNode == null
              ? []
              : [parentNode._component, ...parentNode._context.sequence],
        ),
        _state =
            _component is StatefulComponent ? _component.createState() : null {
    _state
      ?..component = _component as StatefulComponent
      ..context = _context;
  }

  void _initializeState() {
    _state?.initialize();

    _updateSubscription =
        _state?.updateStream.listen((final _) => _stateDidUpdate());
  }

  void _stateDidMount() => _state?.didMount();

  // TODO: Implement this function properly (with diffing).
  void _stateDidUpdate() {
    _disposeChildNodes();
    _initializeChildNodes();
  }

  void _stateWillUnmount() => _state?.willUnmount();

  void _disposeState() {
    _state?.dispose();
    _updateSubscription?.cancel();
  }

  void _initializeChildNodes() {
    final childComponents =
        (_state ?? _component as StatelessComponent).render(_context);

    final childNodes = childComponents
        .map((final childComponent) => Node(childComponent, this))
        .toList();

    _childNodes.addAll(childNodes);

    for (final childNode in _childNodes) {
      childNode.initialize();
    }
  }

  void _disposeChildNodes() {
    for (final childNode in _childNodes) {
      childNode.dispose();
    }

    _childNodes.clear();
  }

  void initialize() {
    _initializeState();
    _initializeChildNodes();
    _stateDidMount();
  }

  void dispose() {
    _stateWillUnmount();
    _disposeChildNodes();
    _disposeState();
  }
}
