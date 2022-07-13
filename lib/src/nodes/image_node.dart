import 'dart:html' as html;

import 'package:dawn/src/nodes/framework_node.dart';
import 'package:dawn/src/widgets/image.dart';

class ImageNode extends FrameworkNode<Image, html.ImageElement> {
  ImageNode({required super.widget, super.parentNode})
      : super(element: html.ImageElement());

  @override
  void initializeElement() {
    super.initializeElement();

    element
      ..src = widget.source
      ..alt = widget.alternativeText;
  }
}
