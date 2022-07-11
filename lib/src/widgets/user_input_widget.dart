import 'package:dawn/src/utils/event_listener.dart';
import 'package:dawn/src/widgets/framework_widget.dart';
import 'package:dawn/src/widgets/input.dart';
import 'package:dawn/src/widgets/textbox.dart';

/// The base class for user input widgets such as [Input], [Textbox], etc.
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
