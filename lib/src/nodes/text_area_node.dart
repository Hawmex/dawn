import 'dart:html' as html;

import 'package:dawn/widgets.dart';

import 'user_input_node.dart';

class TextAreaNode extends UserInputNode<TextArea, html.TextAreaElement> {
  TextAreaNode({
    required super.widget,
    super.parentNode,
  }) : super(element: html.TextAreaElement());

  @override
  void initializeElement() {
    super.initializeElement();
    element.value = widget.value;
  }
}
