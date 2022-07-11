import 'package:dawn/src/widgets/media_widget.dart';

/// An implementation of `<audio />`.
class Audio extends MediaWidget {
  const Audio(
    super.source, {
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
