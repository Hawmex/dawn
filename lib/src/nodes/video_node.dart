import 'dart:html' as html;

import 'package:dawn/widgets.dart';

import 'media_node.dart';

class VideoNode extends MediaNode<Video, html.VideoElement> {
  VideoNode({
    required super.widget,
    super.parentNode,
  }) : super(element: html.VideoElement());

  @override
  void initializeElement() {
    super.initializeElement();
    element.poster = widget.thumbnail ?? '';
  }
}
