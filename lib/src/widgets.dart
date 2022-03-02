import 'dart:html';

import 'package:dawn/src/context.dart';
import 'package:dawn/src/state.dart';
import 'package:dawn/src/style.dart';

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

abstract class FrameworkWidget extends Widget {
  final Style style;

  final EventListener? onPointerDown;
  final EventListener? onPointerUp;
  final EventListener? onPointerEnter;
  final EventListener? onPointerLeave;
  final EventListener? onPress;

  const FrameworkWidget({
    final Style? style,
    this.onPointerDown,
    this.onPointerUp,
    this.onPointerEnter,
    this.onPointerLeave,
    this.onPress,
  }) : style = style ?? const Style.empty();
}

class Text extends FrameworkWidget {
  final String value;

  const Text(
    this.value, {
    final Style? style,
    final EventListener? onPointerDown,
    final EventListener? onPointerUp,
    final EventListener? onPointerEnter,
    final EventListener? onPointerLeave,
    final EventListener? onPress,
  }) : super(
          style: style,
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
        );
}

class Container extends FrameworkWidget {
  final List<Widget> _children;

  const Container(
    final List<Widget> children, {
    final Style? style,
    final EventListener? onPointerDown,
    final EventListener? onPointerUp,
    final EventListener? onPointerEnter,
    final EventListener? onPointerLeave,
    final EventListener? onPress,
  })  : _children = children,
        super(
          style: style,
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
        );

  List<Widget> get children => List.unmodifiable(_children);
}

class Image extends FrameworkWidget {
  final String source;

  const Image(
    this.source, {
    final Style? style,
    final EventListener? onPointerDown,
    final EventListener? onPointerUp,
    final EventListener? onPointerEnter,
    final EventListener? onPointerLeave,
    final EventListener? onPress,
  }) : super(
          style: style,
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
        );
}
