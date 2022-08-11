import 'dart:html' as html;

import 'package:dawn/animation.dart';
import 'package:dawn/foundation.dart';

import 'container.dart';
import 'stateful_widget.dart';
import 'stateless_builder.dart';
import 'widget.dart';

final _navigatorState = _NavigatorState();

extension Navigation on BuildContext {
  void pushRoute({required final StatelessWidgetBuilder builder}) {
    _navigatorState._pushRoute(builder: builder);
  }

  void pop() {
    _navigatorState._pop();
  }

  void pushModal({required final void Function() onPop}) {
    _navigatorState._pushModal(onPop: onPop);
  }
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

enum _NavigationAction { none, pop, push }

class _NavigatorState extends State<Navigator> {
  final _modalsStack = <void Function()>[];
  late final _routesStack = [widget.child];
  _NavigationAction _lastNavigationAction = _NavigationAction.none;

  int get _browserHistoryState => html.window.history.state;

  Animation? get _routeAnimation {
    switch (_lastNavigationAction) {
      case _NavigationAction.none:
        return null;
      case _NavigationAction.pop:
        return widget.popAnimation;
      case _NavigationAction.push:
        return widget.pushAnimation;
    }
  }

  void _pushBrowserHistory() {
    html.window.history.pushState(
      _routesStack.length + _modalsStack.length,
      '',
      null,
    );
  }

  void _browserHistoryBack() => html.window.history.back();

  void _pushModal({required final void Function() onPop}) {
    _modalsStack.add(onPop);
    _pushBrowserHistory();
  }

  void _pushRoute({required final StatelessWidgetBuilder builder}) {
    setState(() {
      _routesStack.add(builder(context));
      _lastNavigationAction = _NavigationAction.push;
    });

    _pushBrowserHistory();
  }

  void _pop() {
    if (_modalsStack.isNotEmpty) {
      _modalsStack
        ..last()
        ..removeLast();
    } else {
      setState(() {
        _routesStack.removeLast();
        _lastNavigationAction = _NavigationAction.pop;
      });
    }

    if (_browserHistoryState > _routesStack.length + _modalsStack.length) {
      _browserHistoryBack();
    }
  }

  void _browserHistoryPopHandler(final html.Event event) {
    if (_browserHistoryState > _routesStack.length + _modalsStack.length) {
      _browserHistoryBack();
    } else if (_browserHistoryState <
        _routesStack.length + _modalsStack.length) {
      _pop();
    }
  }

  @override
  void initialize() {
    super.initialize();

    html.window
      ..history.replaceState(1, '', null)
      ..addEventListener('popstate', _browserHistoryPopHandler);
  }

  @override
  void dispose() {
    html.window.removeEventListener('popstate', _browserHistoryPopHandler);
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final inactiveRoutes = [..._routesStack];
    final activeRoute = inactiveRoutes.removeLast();

    return Container([
      for (final inactiveRoute in inactiveRoutes)
        Container([inactiveRoute], style: const Style({'display': 'none'})),
      Container([activeRoute], animation: _routeAnimation)
    ]);
  }
}
