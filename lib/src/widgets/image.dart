import 'package:dawn/src/widgets.dart';

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
