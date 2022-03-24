import 'dart:html' as html;

import 'package:dawn/src/widgets.dart';

import 'node.dart';
import 'user_input_node.dart';

class InputNode extends UserInputNode<Input, html.TextInputElement> {
  InputNode(final Input widget, {final Node? parentNode})
      : super(widget, element: html.TextInputElement(), parentNode: parentNode);

  @override
  void initializeElement() {
    super.initializeElement();
    element.value = widget.value;
  }
}
