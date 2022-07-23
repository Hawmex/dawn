import 'package:dawn/foundation.dart';

import 'framework_widget.dart';

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
