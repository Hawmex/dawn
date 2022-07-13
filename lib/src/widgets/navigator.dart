import 'dart:math';

import 'package:dawn/src/nodes/stateful_node.dart';
import 'package:dawn/src/utils/animation.dart';
import 'package:dawn/src/utils/context.dart';
import 'package:dawn/src/widgets/container.dart';
import 'package:dawn/src/widgets/stateful_widget.dart';
import 'package:dawn/src/widgets/widget.dart';

final _navigatorState = _NavigatorState();

/// Adds navigation functionality to [Context].
extension Navigation on Context {
  /// Builds a new [Widget] at [Navigator].
  void push({required final Widget Function(Context context) builder}) =>
      _navigatorState.push(builder: builder);

  /// Goes to the previous navigation state.
  void pop() => _navigatorState.pop();
}

/// A simple navigator widget.
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

enum _NavigationAction { push, pop }

class _NavigatorState extends State<Navigator> {
  late final List<Widget> childStack = [widget.child];

  _NavigationAction lastAction = _NavigationAction.push;

  void push({required final Widget Function(Context context) builder}) {
    setState(() {
      childStack.add(builder(context));
      lastAction = _NavigationAction.push;
    });
  }

  void pop() {
    if (childStack.isNotEmpty) {
      setState(() {
        childStack.removeLast();
        lastAction = _NavigationAction.pop;
      });
    }
  }

  @override
  Widget build(final Context context) {
    return Container(
      children: [childStack.last],
      key: Random().nextDouble().toString(),
      animation: lastAction == _NavigationAction.push
          ? widget.pushAnimation
          : widget.popAnimation,
    );
  }
}
