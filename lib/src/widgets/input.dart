import 'package:dawn/src/widgets.dart';

class Input extends UserInputWidget {
  final String value;
  final bool hideValue;

  const Input(
    this.value, {
    this.hideValue = false,
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
