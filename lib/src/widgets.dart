import 'dart:async';
import 'dart:html';

import 'package:dawn/src/context.dart';
import 'package:dawn/src/styles.dart';

typedef EventListener = void Function(Event event);

abstract class Widget {
  const Widget();
}

mixin Buildable {
  Widget build(final Context context);
}

abstract class StatelessWidget extends Widget with Buildable {
  const StatelessWidget() : super();
}

abstract class StatefulWidget extends Widget {
  const StatefulWidget() : super();

  State<StatefulWidget> createState();
}

abstract class State<T extends StatefulWidget> with Buildable {
  late final T widget;
  late final Context context;

  final _updateController = StreamController<void>.broadcast();

  bool _isMounted = false;

  Stream<void> get updateStream => _updateController.stream;
  bool get isMounted => _isMounted;

  void setState(final void Function() callback) {
    callback();
    if (isMounted) didUpdate();
  }

  void initialize() {}
  void didMount() => _isMounted = true;
  void didUpdate() => _updateController.add(null);
  void willUnmount() {}
  void dispose() => _isMounted = false;
}

abstract class FrameworkWidget extends Widget {
  final Styles styles;

  final List<EventListener>? onPointerDown;
  final List<EventListener>? onPointerUp;
  final List<EventListener>? onPointerEnter;
  final List<EventListener>? onPointerLeave;
  final List<EventListener>? onPress;

  const FrameworkWidget({
    final Styles? styles,
    this.onPointerDown,
    this.onPointerUp,
    this.onPointerEnter,
    this.onPointerLeave,
    this.onPress,
  }) : styles = styles ?? const Styles.empty();
}

class Text extends FrameworkWidget {
  final String value;

  const Text(
    this.value, {
    final Styles? styles,
    final List<EventListener>? onPointerDown,
    final List<EventListener>? onPointerUp,
    final List<EventListener>? onPointerEnter,
    final List<EventListener>? onPointerLeave,
    final List<EventListener>? onPress,
  }) : super(
          styles: styles,
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
        );
}

class Container extends FrameworkWidget {
  final List<Widget> children;

  const Container(
    this.children, {
    final Styles? styles,
    final List<EventListener>? onPointerDown,
    final List<EventListener>? onPointerUp,
    final List<EventListener>? onPointerEnter,
    final List<EventListener>? onPointerLeave,
    final List<EventListener>? onPress,
  }) : super(
          styles: styles,
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
        );
}
