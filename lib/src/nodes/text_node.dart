import 'dart:html' as html;

import 'package:dawn/src/nodes.dart';
import 'package:dawn/src/widgets.dart';

class TextNode extends FrameworkNode<Text, html.SpanElement> {
  TextNode(super.widget, {super.parentNode})
      : super(element: html.SpanElement());

  @override
  void initializeElement() {
    super.initializeElement();
    element.text = widget.value;
  }
}
