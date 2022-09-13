import 'dart:async';
import 'dart:html' as html;

import 'package:dawn/animation.dart';
import 'package:dawn/foundation.dart';

import 'container.dart';
import 'future_builder.dart';
import 'stateful_widget.dart';
import 'stateless_builder.dart';
import 'widget.dart';

final _navigatorState = _NavigatorState();

/// Navigation functions that are added to `context`.
extension Navigation on BuildContext {
  /// Pushes a new route synchronously.
  void pushRoute({required final StatelessWidgetBuilder builder}) =>
      _navigatorState._pushRoute(builder: builder);

  /// Pushes a new route lazily. A placeholder widget is rendered while the
  /// route is being loaded.
  void pushRouteLazily({
    required final Future<dynamic> Function() loader,
    required final StatelessWidgetBuilder builder,
    required final Widget initialData,
  }) =>
      pushRoute(
        builder: (final context) => FutureBuilder<Widget>(
          (final context, final snapshot) => snapshot.data!,
          initialData: initialData,
          future: Future(() async {
            await loader();
            return builder(context);
          }),
        ),
      );

  /// Pushes a new modal to the navigation state.
  void pushModal({required final void Function() onPop}) =>
      _navigatorState._pushModal(onPop: onPop);

  /// Pops the latest modal. If all modals are popped, the current route
  /// is popped.
  void pop() => _navigatorState._pop();
}

/// A navigation outlet.
///
/// **Notice:** Only a single instance of [Navigator] should be created in an
/// app.
class Navigator extends StatefulWidget {
  final Widget child;

  /// The animation that should be applied to the child after it's been pushed.
  final Animation? pushAnimation;

  /// The animation that should be applied to the child after the previous one
  /// was popped.
  final Animation? popAnimation;

  /// Creates a new [Navigator] that is a navigation outlet.
  ///
  /// **Notice:** Only a single instance of [Navigator] should be created in an
  /// app.
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
  _NavigationAction _lastNavigationAction = _NavigationAction.none;
  final _modalsStack = <void Function()>[];
  late final _routesStack = [widget.child];

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
    return Container(
      [_routesStack.last],
      animation: _routeAnimation,
      key: _routesStack.length.toString(),
    );
  }
}
