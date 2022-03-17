part of dawn;

abstract class Widget {
  const Widget();
}

abstract class StatelessWidget extends Widget with Buildable {
  const StatelessWidget();
}

abstract class StatefulWidget extends Widget {
  const StatefulWidget();

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
  });
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
  }) : super(
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
          style: style,
          animation: animation,
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
  }) : super(
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
          style: style,
          animation: animation,
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
  }) : super(
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
          style: style,
          animation: animation,
        );
}

abstract class UserInputWidget extends FrameworkWidget {
  final UserInputController userInputController;

  const UserInputWidget(
    this.userInputController, {
    final EventListener? onPointerDown,
    final EventListener? onPointerUp,
    final EventListener? onPointerEnter,
    final EventListener? onPointerLeave,
    final EventListener? onPress,
    final Style? style,
    final Animation? animation,
  }) : super(
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
          style: style,
          animation: animation,
        );
}

class Input extends UserInputWidget {
  const Input(
    final UserInputController userInputController, {
    final EventListener? onPointerDown,
    final EventListener? onPointerUp,
    final EventListener? onPointerEnter,
    final EventListener? onPointerLeave,
    final EventListener? onPress,
    final Style? style,
    final Animation? animation,
  }) : super(
          userInputController,
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
          style: style,
          animation: animation,
        );
}

class TextBox extends UserInputWidget {
  const TextBox(
    final UserInputController userInputController, {
    final EventListener? onPointerDown,
    final EventListener? onPointerUp,
    final EventListener? onPointerEnter,
    final EventListener? onPointerLeave,
    final EventListener? onPress,
    final Style? style,
    final Animation? animation,
  }) : super(
          userInputController,
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
          style: style,
          animation: animation,
        );
}
