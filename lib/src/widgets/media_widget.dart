import 'package:dawn/src/utils.dart';
import 'package:dawn/src/widgets.dart';

/// The base class for media widgets such as [Video], [Audio], etc.
abstract class MediaWidget extends FrameworkWidget {
  final String source;
  final bool showControls;
  final bool loop;
  final bool muted;
  final bool autoplay;

  final EventListener? onEnd;
  final EventListener? onPause;
  final EventListener? onPlay;
  final EventListener? onSeekStart;
  final EventListener? onSeekEnd;
  final EventListener? onVolumeChange;

  const MediaWidget(
    this.source, {
    this.showControls = true,
    this.loop = false,
    this.muted = false,
    this.autoplay = false,
    this.onEnd,
    this.onPause,
    this.onPlay,
    this.onSeekStart,
    this.onSeekEnd,
    this.onVolumeChange,
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
