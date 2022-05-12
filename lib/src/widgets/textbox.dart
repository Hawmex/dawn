import 'user_input_widget.dart';

class Textbox extends UserInputWidget {
  final String value;

  const Textbox(
    this.value, {
    final super.onChange,
    final super.onInput,
    final super.onPointerDown,
    final super.onPointerUp,
    final super.onPointerEnter,
    final super.onPointerLeave,
    final super.onPress,
    final super.style,
    final super.animation,
    final super.key,
  });
}