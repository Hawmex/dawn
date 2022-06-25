import 'framework_widget.dart';

class Text extends FrameworkWidget {
  final String value;

  const Text(
    this.value, {
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
