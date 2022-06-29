import 'dart:html' as html;

import 'package:dawn/src/nodes.dart';
import 'package:dawn/src/widgets.dart';

class VideoNode extends FrameworkNode<Video, html.VideoElement> {
  VideoNode(super.widget, {super.parentNode})
      : super(element: html.VideoElement());

  @override
  void initializeElement() {
    super.initializeElement();

    element
      ..src = widget.source
      ..poster = widget.thumbnail ?? ''
      ..controls = widget.showControls
      ..loop = widget.loop
      ..muted = widget.muted
      ..autoplay = widget.autoplay
      ..addEventListener('ended', widget.onEnd)
      ..addEventListener('pause', widget.onPause)
      ..addEventListener('play', widget.onPlay)
      ..addEventListener('seeking', widget.onSeekStart)
      ..addEventListener('seeked', widget.onSeekEnd)
      ..addEventListener('volumechange', widget.onVolumeChange);
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
