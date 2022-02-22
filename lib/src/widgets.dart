import 'dart:async';
import 'dart:html';

import 'package:dawn/src/context.dart';
import 'package:dawn/src/styles.dart';

typedef EventListener = void Function(Event event);
typedef EventListeners = List<EventListener>;

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
  final _updateController = StreamController<void>.broadcast();

  bool _isMounted = false;

  late final T widget;
  late final Context context;

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

  final EventListeners? onPointerDown;
  final EventListeners? onPointerUp;
  final EventListeners? onPointerEnter;
  final EventListeners? onPointerLeave;
  final EventListeners? onPress;

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
    final EventListeners? onPointerDown,
    final EventListeners? onPointerUp,
    final EventListeners? onPointerEnter,
    final EventListeners? onPointerLeave,
    final EventListeners? onPress,
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
    final EventListeners? onPointerDown,
    final EventListeners? onPointerUp,
    final EventListeners? onPointerEnter,
    final EventListeners? onPointerLeave,
    final EventListeners? onPress,
  }) : super(
          styles: styles,
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
        );
}
