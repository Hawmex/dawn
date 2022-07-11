import 'package:dawn/src/utils/animation.dart';
import 'package:dawn/src/utils/event_listener.dart';
import 'package:dawn/src/utils/style.dart';
import 'package:dawn/src/widgets/container.dart';
import 'package:dawn/src/widgets/image.dart';
import 'package:dawn/src/widgets/text.dart';
import 'package:dawn/src/widgets/widget.dart';

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
