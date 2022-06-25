import 'framework_widget.dart';

abstract class UserInputWidget extends FrameworkWidget {
  final EventListener? onChange;
  final EventListener? onInput;

  const UserInputWidget({
    this.onChange,
    this.onInput,
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
