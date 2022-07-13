import 'dart:html' as html;

import 'package:dawn/src/nodes/media_node.dart';
import 'package:dawn/src/widgets/video.dart';

class VideoNode extends MediaNode<Video, html.VideoElement> {
  VideoNode({required super.widget, super.parentNode})
      : super(element: html.VideoElement());

  @override
  void initializeElement() {
    super.initializeElement();
    element.poster = widget.thumbnail ?? '';
  }
}
