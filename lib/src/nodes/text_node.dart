import 'dart:html' as html;

import 'package:dawn/src/widgets.dart';

import 'framework_node.dart';
import 'node.dart';

class TextNode extends FrameworkNode<Text, html.SpanElement> {
  TextNode(
    final Text widget, {
    final Node<Widget>? parentNode,
  }) : super(widget, element: html.SpanElement(), parentNode: parentNode);

  @override
  void initializeElement() {
    super.initializeElement();
    element.text = widget.value;
  }
}
