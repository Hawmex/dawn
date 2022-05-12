import 'framework_widget.dart';
import 'widget.dart';

class Container extends FrameworkWidget {
  final List<Widget> children;

  const Container(
    this.children, {
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
