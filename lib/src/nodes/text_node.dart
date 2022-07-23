import 'dart:html' as html;

import 'package:dawn/widgets.dart';

import 'framework_node.dart';

class TextNode extends FrameworkNode<Text, html.SpanElement> {
  TextNode({
    required super.widget,
    super.parentNode,
  }) : super(element: html.SpanElement());

  @override
  void initializeElement() {
    super.initializeElement();
    element.text = widget.value;
  }
}
