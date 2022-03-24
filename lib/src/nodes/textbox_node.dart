import 'dart:html' as html;

import 'package:dawn/src/widgets.dart';

import 'node.dart';
import 'user_input_node.dart';

class TextBoxNode extends UserInputNode<Textbox, html.TextAreaElement> {
  TextBoxNode(final Textbox widget, {final Node<Widget>? parentNode})
      : super(widget, element: html.TextAreaElement(), parentNode: parentNode);

  @override
  void initializeElement() {
    super.initializeElement();
    element.value = widget.value;
  }
}
