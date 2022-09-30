import 'dart:async';
import 'dart:html' as html;

import 'package:dawn/animation.dart';
import 'package:dawn/core.dart';

import 'container.dart';
import 'future_builder.dart';
import 'stateful_widget.dart';
import 'stateless_builder.dart';
import 'widget.dart';

final _navigatorState = _NavigatorState();

extension Navigation on BuildContext {
  void pushRoute({required final StatelessWidgetBuilder builder}) =>
      _navigatorState._pushRoute(builder: builder);

  void pushRouteLazily({
    required final Future<dynamic> Function() loader,
    required final StatelessWidgetBuilder builder,
  }) =>
      _navigatorState._pushRouteLazily(loader: loader, builder: builder);

  void pushModal({required final void Function() onPop}) =>
      _navigatorState._pushModal(onPop: onPop);

  void pop() => _navigatorState._pop();
}

class Navigator extends StatefulWidget {
  final Widget child;
  final Widget loading;
  final Animation? pushAnimation;
  final Animation? popAnimation;

  const Navigator({
    required this.child,
    this.loading = const Container([]),
    this.pushAnimation,
    this.popAnimation,
    super.key,
  });

  @override
  State createState() => _navigatorState;
}

enum _NavigationAction { none, pop, push }

class _NavigatorState extends State<Navigator> {
  _NavigationAction _lastNavigationAction = _NavigationAction.none;
  final _modalsStack = <void Function()>[];
  late final _routesStack = [widget.child];
  late final StreamSubscription<html.Event> _browserHistoryPopSubscription;

  int get _browserHistoryState => html.window.history.state as int;

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

  void _pushRouteLazily({
    required final Future<dynamic> Function() loader,
    required final StatelessWidgetBuilder builder,
  }) {
    _pushRoute(
      builder: (final context) => FutureBuilder<Widget>(
        (final context, final snapshot) => snapshot.data!,
        initialData: widget.loading,
        future: Future(() async {
          await loader();
          return builder(context);
        }),
      ),
    );
  }

  void _pop() {
    if (_browserHistoryState >= _routesStack.length + _modalsStack.length) {
      _browserHistoryBack();
    }

    if (_modalsStack.isNotEmpty) {
      _modalsStack
        ..last()
        ..removeLast();
    } else if (_routesStack.length > 1) {
      setState(() {
        _routesStack.removeLast();
        _lastNavigationAction = _NavigationAction.pop;
      });
    }
  }

  void _browserHistoryPopHandler(final html.PopStateEvent event) {
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

    html.window.history.replaceState(1, '', null);

    _browserHistoryPopSubscription = html.window.on['popstate'].listen(
      (final event) => _browserHistoryPopHandler(event as html.PopStateEvent),
    );
  }

  @override
  void dispose() {
    _browserHistoryPopSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return Container(
      [_routesStack.last],
      animation: _routeAnimation,
      key: _routesStack.length.toString(),
    );
  }
}
