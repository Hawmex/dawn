import 'dart:async';

import 'package:dawn/src/core/components.dart';
import 'package:dawn/src/core/context.dart';

class Node {
  late final StreamSubscription<void>? _updateStreamSubscription;

  final Component _component;
  final Context _context;
  final State<StatefulComponent>? _state;

  final _childNodes = <Node>[];

  bool _isActive = false;

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

  List<Node> _setupChildNodes(final List<Component> renderOutput) {
    return renderOutput
        .map((final newChildComponent) => Node(newChildComponent, this))
        .toList();
  }

  void _initializeState() {
    _state?.initialize();

    _updateStreamSubscription =
        _state?.updateStream.listen((final _) => _stateDidUpdate());
  }

  void _stateDidMount() => _state?.didMount();

  void _stateDidUpdate() {
    final oldChildNodes = _childNodes;
    final newChildNodes = _setupChildNodes(_state!.render(_context));

    int searchIndex = 0;

    for (final oldChildNode in oldChildNodes) {
      final index = newChildNodes.indexWhere(
        (final newChildNode) =>
            newChildNode._component == oldChildNode._component,
        searchIndex,
      );

      if (index < 0) {
        oldChildNode.dispose();
      } else {
        searchIndex = index + 1;
        newChildNodes[index] = oldChildNode;
      }
    }

    _childNodes.clear();
    _childNodes.addAll(newChildNodes);

    for (final childNode in _childNodes) {
      if (!childNode._isActive) childNode.initialize();
    }
  }

  void _stateWillUnmount() => _state?.willUnmount();

  void _disposeState() {
    _state?.dispose();
    _updateStreamSubscription?.cancel();
  }

  void _initializeChildNodes() {
    final childNodes = _setupChildNodes(
      (_state ?? _component as StatelessComponent).render(_context),
    );

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
    _isActive = true;
    _initializeState();
    _initializeChildNodes();
    _stateDidMount();
  }

  void dispose() {
    _stateWillUnmount();
    _disposeChildNodes();
    _disposeState();
    _isActive = false;
  }
}
