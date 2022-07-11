import 'package:dawn/src/widgets.dart';

/// An implementation of `<input />`.
class Input extends UserInputWidget {
  final String value;
  final String? type;

  const Input(
    this.value, {
    this.type,
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
