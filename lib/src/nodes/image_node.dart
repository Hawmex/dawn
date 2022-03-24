import 'dart:html' as html;

import 'package:dawn/src/widgets.dart';

import 'framework_node.dart';
import 'node.dart';

class ImageNode extends FrameworkNode<Image, html.ImageElement> {
  ImageNode(
    final Image widget, {
    final Node<Widget>? parentNode,
  }) : super(widget, element: html.ImageElement(), parentNode: parentNode);

  @override
  void initializeElement() {
    super.initializeElement();
    element.src = widget.source;
  }
}
