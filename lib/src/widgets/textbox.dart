import 'package:dawn/src/widgets.dart';

/// An implementation of `<textarea />`.
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
