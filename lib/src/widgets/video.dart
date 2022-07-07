import 'package:dawn/src/widgets.dart';

/// An implementation of `<video />`.
class Video extends FrameworkWidget {
  final String source;
  final String? alternativeText;
  final String? thumbnail;
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

  const Video(
    this.source, {
    this.alternativeText,
    this.thumbnail,
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
