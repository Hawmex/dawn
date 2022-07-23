import 'dart:html' as html;

import 'package:dawn/animation.dart';
import 'package:dawn/foundation.dart';

import 'container.dart';
import 'stateful_widget.dart';
import 'widget.dart';

final _navigatorState = _NavigatorState();

extension Navigation on BuildContext {
  void push({required final Widget Function(BuildContext context) builder}) =>
      _navigatorState.push(builder: builder);

  void pop() => _navigatorState.pop();

  void addModal({required final void Function() onPop}) =>
      _navigatorState.addModal(onPop: onPop);
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
  final List<void Function()> modalStack = [];

  late final List<Widget> childStack = [widget.child];

  _NavigationAction lastAction = _NavigationAction.none;

  int get historyState => html.window.history.state;

  void pushHistoryState() => html.window.history
      .pushState(childStack.length + modalStack.length, '', null);

  void historyBack() => html.window.history.back();

  void addModal({required final void Function() onPop}) {
    modalStack.add(onPop);
    pushHistoryState();
  }

  void push({required final Widget Function(BuildContext context) builder}) {
    setState(() {
      childStack.add(builder(context));
      lastAction = _NavigationAction.push;
      pushHistoryState();
    });
  }

  void pop() {
    setState(() {
      if (modalStack.isNotEmpty) {
        modalStack
          ..last()
          ..removeLast();
      } else {
        childStack.removeLast();
        lastAction = _NavigationAction.pop;
      }

      if (historyState > childStack.length + modalStack.length) historyBack();
    });
  }

  @override
  void initialize() {
    super.initialize();

    html.window
      ..history.replaceState(1, '', null)
      ..addEventListener('popstate', (final event) {
        if (historyState > childStack.length + modalStack.length) {
          historyBack();
        } else if (historyState < childStack.length + modalStack.length) {
          pop();
        }
      });
  }

  @override
  Widget build(final BuildContext context) {
    return Container(
      [childStack.last],
      key: childStack.length.toString(),
      animation: lastAction == _NavigationAction.push
          ? widget.pushAnimation
          : lastAction == _NavigationAction.pop
              ? widget.popAnimation
              : null,
    );
  }
}
