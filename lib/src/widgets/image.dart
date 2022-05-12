import 'framework_widget.dart';

class Image extends FrameworkWidget {
  final String source;

  const Image(
    this.source, {
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
