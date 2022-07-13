import 'package:dawn/src/widgets/media_widget.dart';

/// An implementation of `<video />`.
class Video extends MediaWidget {
  final String? thumbnail;

  const Video({
    required super.source,
    this.thumbnail,
    super.showControls,
    super.loop,
    super.muted,
    super.autoplay,
    super.onEnd,
    super.onPause,
    super.onPlay,
    super.onSeekStart,
    super.onSeekEnd,
    super.onVolumeChange,
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
