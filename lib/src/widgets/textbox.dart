import 'framework_widget.dart';
import 'user_input_widget.dart';

class Textbox extends UserInputWidget {
  final String value;

  const Textbox(
    this.value, {
    final EventListener? onChange,
    final EventListener? onInput,
    final EventListener? onPointerDown,
    final EventListener? onPointerUp,
    final EventListener? onPointerEnter,
    final EventListener? onPointerLeave,
    final EventListener? onPress,
    final Style? style,
    final Animation? animation,
    final String? key,
  }) : super(
          onChange: onChange,
          onInput: onInput,
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          onPointerEnter: onPointerEnter,
          onPointerLeave: onPointerLeave,
          onPress: onPress,
          style: style,
          animation: animation,
          key: key,
        );
}
