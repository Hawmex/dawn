import 'framework_widget.dart';
import 'widget.dart';

class Container extends FrameworkWidget {
  final List<Widget> children;

  const Container(
    this.children, {
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
