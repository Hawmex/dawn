import 'dart:html' as html;

import 'package:dawn/widgets.dart';

import 'media_node.dart';

class AudioNode extends MediaNode<Audio, html.AudioElement> {
  AudioNode({
    required super.widget,
    super.parentNode,
  }) : super(element: html.AudioElement());
}
