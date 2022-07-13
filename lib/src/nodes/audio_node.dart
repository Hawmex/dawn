import 'dart:html' as html;

import 'package:dawn/src/nodes/media_node.dart';
import 'package:dawn/src/widgets/audio.dart';

class AudioNode extends MediaNode<Audio, html.AudioElement> {
  AudioNode({required super.widget, super.parentNode})
      : super(element: html.AudioElement());
}
