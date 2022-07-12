import 'package:dawn/src/widgets/user_input_widget.dart';

/// An implementation of `<input />`.
class Input extends UserInputWidget {
  final String value;
  final String type;

  const Input.password(
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
  }) : type = 'password';

  const Input.text(
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
  }) : type = 'text';
}
