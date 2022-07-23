import 'dart:html' as html;

import 'package:dawn/widgets.dart';

import 'user_input_node.dart';

class InputNode extends UserInputNode<Input, html.InputElement> {
  InputNode({
    required super.widget,
    super.parentNode,
  }) : super(element: html.InputElement());

  @override
  void initializeElement() {
    super.initializeElement();

    element
      ..type = widget.type
      ..value = widget.value;
  }
}
