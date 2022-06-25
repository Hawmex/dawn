import 'framework_widget.dart';

class Image extends FrameworkWidget {
  final String source;

  const Image(
    this.source, {
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
