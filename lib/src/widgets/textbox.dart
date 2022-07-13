import 'package:dawn/src/widgets/user_input_widget.dart';

/// An implementation of `<textarea />`.
class Textbox extends UserInputWidget {
  final String value;

  const Textbox({
    required this.value,
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
