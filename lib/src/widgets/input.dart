import 'user_input_widget.dart';

class Input extends UserInputWidget {
  final String value;

  const Input(
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
