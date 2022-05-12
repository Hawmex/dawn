import 'framework_widget.dart';

abstract class UserInputWidget extends FrameworkWidget {
  final EventListener? onChange;
  final EventListener? onInput;

  const UserInputWidget({
    this.onChange,
    this.onInput,
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
