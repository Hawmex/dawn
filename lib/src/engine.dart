import 'dart:async';
import 'dart:html';

import 'package:dawn/src/components.dart';

void runApp(final Component app) {
  final node = Node(app);

  document.body!.append(node._element);
  node.initialize();
}

class Context {
  final List<Node> _sequence;

  const Context(this._sequence);

  List<Node> get sequence => List.unmodifiable(_sequence);

  T getParentOfExactType<T extends Component>() {
    return sequence.firstWhere(
      (final contextEntry) => contextEntry._component.runtimeType == T,
    ) as T;
  }
}

class Node {
  late final StreamSubscription<void>? _updateStreamSubscription;

  final State<StatefulComponent>? _state;
  final Context _context;
  final Element _element;
  final Component _component;

  final _childNodes = <Node>[];

  bool _isActive = false;

  Node(this._component, [final Node? parentNode])
      : _context = Context(
          parentNode == null
              ? []
              : [parentNode, ...parentNode._context.sequence],
        ),
        _state =
            _component is StatefulComponent ? _component.createState() : null,
        _element = _component is Text ? SpanElement() : DivElement() {
    final component = _component;

    _state
      ?..component = component as StatefulComponent
      ..context = _context;

    _element.setAttribute('style', _component.styles.rules);

    if (_element is SpanElement) {
      _element.text = (component as Text).value;
    }
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
        oldChildNode._element.remove();
      } else {
        searchIndex = index + 1;
        newChildNodes[index] = oldChildNode;
      }
    }

    _childNodes.clear();
    _childNodes.addAll(newChildNodes);

    for (final childNode in _childNodes) {
      if (!childNode._isActive) {
        final index = _childNodes.indexOf(childNode);

        if (_element.children.length <= index) {
          _element.append(childNode._element);
        } else {
          _element.insertBefore(childNode._element, _element.children[index]);
        }

        childNode.initialize();
      }
    }
  }

  void _stateWillUnmount() => _state?.willUnmount();

  void _disposeState() {
    _state?.dispose();
    _updateStreamSubscription?.cancel();
  }

  void _initializeChildNodes() {
    final component = _component;

    // TODO
    if (component is Renderable) {
      _childNodes
          .addAll(_setupChildNodes((component as Renderable).render(_context)));
    } else if (_state != null) {
      _childNodes.addAll(_setupChildNodes(_state!.render(_context)));
    }

    for (final childNode in _childNodes) {
      _element.append(childNode._element);
      childNode.initialize();
    }
  }

  void _disposeChildNodes() {
    for (final childNode in _childNodes) {
      childNode.dispose();
      childNode._element.remove();
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
