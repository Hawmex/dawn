import 'dart:html' as html;

import 'package:dawn/src/nodes.dart';
import 'package:dawn/src/widgets.dart';

abstract class MediaNode<T extends MediaWidget, U extends html.MediaElement>
    extends FrameworkNode<T, U> {
  MediaNode(super.widget, {required super.element, super.parentNode});

  @override
  void initializeElement() {
    super.initializeElement();

    element
      ..addEventListener('ended', widget.onEnd)
      ..addEventListener('pause', widget.onPause)
      ..addEventListener('play', widget.onPlay)
      ..addEventListener('seeking', widget.onSeekStart)
      ..addEventListener('seeked', widget.onSeekEnd)
      ..addEventListener('volumechange', widget.onVolumeChange)
      ..src = widget.source
      ..controls = widget.showControls
      ..loop = widget.loop
      ..muted = widget.muted
      ..autoplay = widget.autoplay;
  }

  @override
  void disposeElement() {
    element
      ..removeEventListener('ended', widget.onEnd)
      ..removeEventListener('pause', widget.onPause)
      ..removeEventListener('play', widget.onPlay)
      ..removeEventListener('seeking', widget.onSeekStart)
      ..removeEventListener('seeked', widget.onSeekEnd)
      ..removeEventListener('volumechange', widget.onVolumeChange);

    super.disposeElement();
  }
}
