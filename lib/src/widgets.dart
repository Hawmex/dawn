part of dawn;

abstract class Widget {
  final String? key;

  const Widget({this.key});
}

abstract class StatelessWidget extends Widget with Buildable {
  const StatelessWidget({final String? key}) : super(key: key);
}

abstract class StatefulWidget extends Widget {
  const StatefulWidget({final String? key}) : super(key: key);

  State<StatefulWidget> createState();
}

typedef EventListener = void Function(html.Event event);

abstract class FrameworkWidget extends Widget {
  final EventListener? onPointerDown;
  final EventListener? onPointerUp;
  final EventListener? onPointerEnter;
  final EventListener? onPointerLeave;
  final EventListener? onPress;
  final Style? style;
  final Animation? animation;

  const FrameworkWidget({
    this.onPointerDown,
    this.onPointerUp,
    this.onPointerEnter,
    this.onPointerLeave,
    this.onPress,
    this.style,
    this.animation,
    final String? key,
  }) : super(key: key);
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
    final Animation? animation,
    final String? key,
  }) : super(
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
          style: style,
          animation: animation,
          key: key,
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
    final Animation? animation,
    final String? key,
  }) : super(
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
          style: style,
          animation: animation,
          key: key,
        );
}

class Container extends FrameworkWidget {
  final List<Widget> children;

  const Container(
    this.children, {
    final EventListener? onPointerDown,
    final EventListener? onPointerUp,
    final EventListener? onPointerEnter,
    final EventListener? onPointerLeave,
    final EventListener? onPress,
    final Style? style,
    final Animation? animation,
    final String? key,
  }) : super(
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
          style: style,
          animation: animation,
          key: key,
        );
}

abstract class UserInputWidget extends FrameworkWidget {
  final UserInputController userInputController;
  final EventListener? onChange;
  final EventListener? onInput;

  const UserInputWidget(
    this.userInputController, {
    this.onChange,
    this.onInput,
    final EventListener? onPointerDown,
    final EventListener? onPointerUp,
    final EventListener? onPointerEnter,
    final EventListener? onPointerLeave,
    final EventListener? onPress,
    final Style? style,
    final Animation? animation,
    final String? key,
  }) : super(
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
          style: style,
          animation: animation,
          key: key,
        );
}

class Input extends UserInputWidget {
  const Input(
    final UserInputController userInputController, {
    final EventListener? onChange,
    final EventListener? onInput,
    final EventListener? onPointerDown,
    final EventListener? onPointerUp,
    final EventListener? onPointerEnter,
    final EventListener? onPointerLeave,
    final EventListener? onPress,
    final Style? style,
    final Animation? animation,
    final String? key,
  }) : super(
          userInputController,
          onChange: onChange,
          onInput: onInput,
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
          style: style,
          animation: animation,
          key: key,
        );
}

class TextBox extends UserInputWidget {
  const TextBox(
    final UserInputController userInputController, {
    final EventListener? onChange,
    final EventListener? onInput,
    final EventListener? onPointerDown,
    final EventListener? onPointerUp,
    final EventListener? onPointerEnter,
    final EventListener? onPointerLeave,
    final EventListener? onPress,
    final Style? style,
    final Animation? animation,
    final String? key,
  }) : super(
          userInputController,
          onChange: onChange,
          onInput: onInput,
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
          style: style,
          animation: animation,
          key: key,
        );
}
