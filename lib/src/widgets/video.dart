import 'media_widget.dart';

class Video extends MediaWidget {
  final String? thumbnail;

  const Video(
    super.source, {
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
    super.style,
    super.animation,
    super.onPress,
    super.onPointerDown,
    super.onPointerUp,
    super.onPointerEnter,
    super.onPointerLeave,
    super.onPointerMove,
    super.onPointerCancel,
    super.onPointerOver,
    super.onPointerOut,
    super.onMouseDown,
    super.onMouseUp,
    super.onMouseEnter,
    super.onMouseLeave,
    super.onMouseMove,
    super.onMouseOver,
    super.onMouseOut,
    super.onTouchStart,
    super.onTouchEnd,
    super.onTouchMove,
    super.onTouchCancel,
    super.key,
  });
}
