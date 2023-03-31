import 'dart:async';
import 'dart:html' as html;

import 'package:dawn/animation.dart';
import 'package:dawn/core.dart';

import 'container.dart';
import 'future_builder.dart';
import 'stateful_widget.dart';
import 'stateless_builder.dart';
import 'widget.dart';

/// A navigation outlet.
///
/// **Notice:** Only a single instance of [Navigator] should be present in an
/// app.
class Navigator extends StatefulWidget {
  static _NavigatorState? _state;

  /// Pushes a new route synchronously.
  static void pushRoute({required final StatelessWidgetBuilder builder}) =>
      _state!._pushRoute(builder: builder);

  /// Pushes a new route lazily. [Navigator.fallback] is rendered while the
  /// route is being loaded.
  static void pushRouteLazily({
    required final Future<dynamic> Function() loader,
    required final StatelessWidgetBuilder builder,
  }) =>
      _state!._pushRouteLazily(loader: loader, builder: builder);

  /// Pushes a new modal to the navigation state.
  static void pushModal({required final void Function() onPop}) =>
      _state!._pushModal(onPop: onPop);

  /// Pops the latest modal. If all modals are popped, the current route
  /// is popped.
  static void pop() => _state!._pop();

  final Widget child;

  /// The widget that should be displayed when a lazy route is being loaded.
  final Widget fallback;

  /// The animation that should be applied to the child after it's been pushed.
  final Animation? pushAnimation;

  /// The animation that should be applied to the child after the previous one
  /// was popped.
  final Animation? popAnimation;

  /// Creates a new instance of [Navigator].
  const Navigator({
    required this.child,
    this.fallback = const Container([]),
    this.pushAnimation,
    this.popAnimation,
    super.key,
    super.ref,
  });

  @override
  State createState() => _NavigatorState();
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
        initialData: widget.fallback,
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

    Navigator._state = this;

    html.window.history.replaceState(1, '', null);

    _browserHistoryPopSubscription = html.window.on['popstate'].listen(
      (final event) => _browserHistoryPopHandler(event as html.PopStateEvent),
    );
  }

  @override
  void dispose() {
    _browserHistoryPopSubscription.cancel();
    Navigator._state = null;
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
