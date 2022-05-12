import 'dart:html' as html;

import 'package:dawn/src/widgets.dart';

import 'framework_node.dart';

class TextNode extends FrameworkNode<Text, html.SpanElement> {
  TextNode(final super._widget, {final super.parentNode})
      : super(element: html.SpanElement());

  @override
  void initializeElement() {
    super.initializeElement();
    element.text = widget.value;
  }
}
