import 'package:dawn/src/widgets/framework_widget.dart';

/// An implementation of `<img />`.
class Image extends FrameworkWidget {
  final String source;
  final String? alternativeText;

  const Image({
    required this.source,
    this.alternativeText,
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
