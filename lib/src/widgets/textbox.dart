import 'user_input_widget.dart';

class Textbox extends UserInputWidget {
  final String value;

  const Textbox(
    this.value, {
    super.onChange,
    super.onInput,
    super.onPointerDown,
    super.onPointerUp,
    super.onPointerEnter,
    super.onPointerLeave,
    super.onPress,
    super.style,
    super.animation,
    super.key,
  });
}
