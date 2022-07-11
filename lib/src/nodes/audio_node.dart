import 'dart:html' as html;

import 'package:dawn/src/nodes.dart';
import 'package:dawn/src/widgets.dart';

class AudioNode extends MediaNode<Audio, html.AudioElement> {
  AudioNode(super.widget, {super.parentNode})
      : super(element: html.AudioElement());
}
