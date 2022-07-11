import 'package:dawn/src/utils.dart';
import 'package:dawn/src/widgets.dart';

/// The base class for Dawn framework widgets such as [Text], [Image],
/// [Container], etc.
abstract class FrameworkWidget extends Widget {
  final EventListener? onPointerDown;
  final EventListener? onPointerUp;
  final EventListener? onPointerEnter;
  final EventListener? onPointerLeave;
  final EventListener? onPress;

  final Style? style;
  final Animation? animation;

  const FrameworkWidget({
    this.onPointerDown,
    this.onPointerUp,
    this.onPointerEnter,
    this.onPointerLeave,
    this.onPress,
    this.style,
    this.animation,
    super.key,
  });
}
