import 'package:dawn/src/widgets.dart';

/// An implementation of `<img />`.
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
