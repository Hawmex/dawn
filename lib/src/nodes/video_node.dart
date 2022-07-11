import 'dart:html' as html;

import 'package:dawn/src/nodes.dart';
import 'package:dawn/src/widgets.dart';

class VideoNode extends MediaNode<Video, html.VideoElement> {
  VideoNode(super.widget, {super.parentNode})
      : super(element: html.VideoElement());

  @override
  void initializeElement() {
    super.initializeElement();
    element.poster = widget.thumbnail ?? '';
  }
}
