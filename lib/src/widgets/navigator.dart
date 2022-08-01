import 'dart:html' as html;

import 'package:dawn/animation.dart';
import 'package:dawn/foundation.dart';

import 'container.dart';
import 'stateful_widget.dart';
import 'stateless_builder.dart';
import 'widget.dart';

final _navigatorState = _NavigatorState();

extension Navigation on BuildContext {
  void pushRoute({required final StatelessWidgetBuilder builder}) =>
      _navigatorState._pushRoute(builder: builder);

  void pop() => _navigatorState._pop();

  void pushModal({required final void Function() onPop}) =>
      _navigatorState._pushModal(onPop: onPop);
}

class Navigator extends StatefulWidget {
  final Widget child;
  final Animation? pushAnimation;
  final Animation? popAnimation;

  const Navigator({
    required this.child,
    this.pushAnimation,
    this.popAnimation,
    super.key,
  });

  @override
  State createState() => _navigatorState;
}

enum _NavigationAction { push, pop, none }

class _NavigatorState extends State<Navigator> {
  _NavigationAction _lastAction = _NavigationAction.none;
  final List<void Function()> _modalStack = [];
  late final List<Widget> _childStack = [widget.child];

  int get historyState => html.window.history.state;

  void _pushHistoryState() => html.window.history
      .pushState(_childStack.length + _modalStack.length, '', null);

  void _historyBack() => html.window.history.back();

  void _pushModal({required final void Function() onPop}) {
    _modalStack.add(onPop);
    _pushHistoryState();
  }

  void _pushRoute({required final StatelessWidgetBuilder builder}) {
    setState(() {
      _childStack.add(builder(context));
      _lastAction = _NavigationAction.push;
    });

    _pushHistoryState();
  }

  void _pop() {
    if (_modalStack.isNotEmpty) {
      _modalStack
        ..last()
        ..removeLast();
    } else {
      setState(() {
        _childStack.removeLast();
        _lastAction = _NavigationAction.pop;
      });
    }

    if (historyState > _childStack.length + _modalStack.length) _historyBack();
  }

  void _popStateHandler(final html.Event event) {
    if (historyState > _childStack.length + _modalStack.length) {
      _historyBack();
    } else if (historyState < _childStack.length + _modalStack.length) {
      _pop();
    }
  }

  @override
  void initialize() {
    super.initialize();

    html.window
      ..history.replaceState(1, '', null)
      ..addEventListener('popstate', _popStateHandler);
  }

  @override
  void dispose() {
    html.window.removeEventListener('popstate', _popStateHandler);
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return Container(
      [_childStack.last],
      key: _childStack.length.toString(),
      animation: _lastAction == _NavigationAction.push
          ? widget.pushAnimation
          : _lastAction == _NavigationAction.pop
              ? widget.popAnimation
              : null,
    );
  }
}
