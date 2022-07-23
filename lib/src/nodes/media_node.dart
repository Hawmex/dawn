import 'dart:html' as html;

import 'package:dawn/widgets.dart';

import 'framework_node.dart';

abstract class MediaNode<T extends MediaWidget, U extends html.MediaElement>
    extends FrameworkNode<T, U> {
  MediaNode({
    required super.widget,
    required super.element,
    super.parentNode,
  });

  @override
  void initializeElement() {
    super.initializeElement();

    addListener(type: 'ended', listener: widget.onEnd);
    addListener(type: 'pause', listener: widget.onPause);
    addListener(type: 'play', listener: widget.onPlay);
    addListener(type: 'seeking', listener: widget.onSeekStart);
    addListener(type: 'seeked', listener: widget.onSeekEnd);
    addListener(type: 'volumechange', listener: widget.onVolumeChange);

    element
      ..src = widget.source
      ..controls = widget.showControls
      ..loop = widget.loop
      ..muted = widget.muted
      ..autoplay = widget.autoplay;
  }

  @override
  void disposeElement() {
    removeListener(type: 'ended', listener: widget.onEnd);
    removeListener(type: 'pause', listener: widget.onPause);
    removeListener(type: 'play', listener: widget.onPlay);
    removeListener(type: 'seeking', listener: widget.onSeekStart);
    removeListener(type: 'seeked', listener: widget.onSeekEnd);
    removeListener(type: 'volumechange', listener: widget.onVolumeChange);
    super.disposeElement();
  }
}
