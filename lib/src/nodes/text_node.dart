import 'dart:html' as html;

import 'package:dawn/src/nodes/framework_node.dart';
import 'package:dawn/src/widgets/text.dart';

class TextNode extends FrameworkNode<Text, html.SpanElement> {
  TextNode(super.widget, {super.parentNode})
      : super(element: html.SpanElement());

  @override
  void initializeElement() {
    super.initializeElement();
    element.text = widget.value;
  }
}
