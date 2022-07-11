import 'dart:html' as html;

import 'package:dawn/src/nodes.dart';
import 'package:dawn/src/widgets.dart';

class ImageNode extends FrameworkNode<Image, html.ImageElement> {
  ImageNode(super.widget, {super.parentNode})
      : super(element: html.ImageElement());

  @override
  void initializeElement() {
    super.initializeElement();

    element
      ..src = widget.source
      ..alt = widget.alternativeText;
  }
}
