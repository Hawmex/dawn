import 'dart:html';

import 'package:dawn/src/context.dart';
import 'package:dawn/src/nodes.dart';
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
  const StatelessWidget();
}

abstract class StatefulWidget extends Widget {
  const StatefulWidget();

  State<StatefulWidget> createState();
}

abstract class FrameworkWidget extends Widget {
  final EventListener? onPointerDown;
  final EventListener? onPointerUp;
  final EventListener? onPointerEnter;
  final EventListener? onPointerLeave;
  final EventListener? onPress;

  final Style style;

  const FrameworkWidget({
    this.onPointerDown,
    this.onPointerUp,
    this.onPointerEnter,
    this.onPointerLeave,
    this.onPress,
    final Style? style,
  }) : style = style ?? const Style.empty();
}

class Text extends FrameworkWidget {
  final String value;

  const Text(
    this.value, {
    final EventListener? onPointerDown,
    final EventListener? onPointerUp,
    final EventListener? onPointerEnter,
    final EventListener? onPointerLeave,
    final EventListener? onPress,
    final Style? style,
  }) : super(
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
          style: style,
        );
}

class Image extends FrameworkWidget {
  final String source;

  const Image(
    this.source, {
    final EventListener? onPointerDown,
    final EventListener? onPointerUp,
    final EventListener? onPointerEnter,
    final EventListener? onPointerLeave,
    final EventListener? onPress,
    final Style? style,
  }) : super(
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
          style: style,
        );
}

class Container extends FrameworkWidget {
  final List<Widget> _children;

  const Container(
    final List<Widget> children, {
    final EventListener? onPointerDown,
    final EventListener? onPointerUp,
    final EventListener? onPointerEnter,
    final EventListener? onPointerLeave,
    final EventListener? onPress,
    final Style? style,
  })  : _children = children,
        super(
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
          style: style,
        );

  List<Widget> get children => List.unmodifiable(_children);
}

abstract class UserInputWidget extends FrameworkWidget {
  final UserInputController controller;

  const UserInputWidget({
    required this.controller,
    final EventListener? onPointerDown,
    final EventListener? onPointerUp,
    final EventListener? onPointerEnter,
    final EventListener? onPointerLeave,
    final EventListener? onPress,
    final Style? style,
  }) : super(
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
          style: style,
        );
}

class Input extends UserInputWidget {
  const Input({
    required final UserInputController controller,
    final EventListener? onPointerDown,
    final EventListener? onPointerUp,
    final EventListener? onPointerEnter,
    final EventListener? onPointerLeave,
    final EventListener? onPress,
    final Style? style,
  }) : super(
          controller: controller,
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
          style: style,
        );
}

class TextBox extends UserInputWidget {
  const TextBox({
    required final UserInputController controller,
    final EventListener? onPointerDown,
    final EventListener? onPointerUp,
    final EventListener? onPointerEnter,
    final EventListener? onPointerLeave,
    final EventListener? onPress,
    final Style? style,
  }) : super(
          controller: controller,
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
          style: style,
        );
}
