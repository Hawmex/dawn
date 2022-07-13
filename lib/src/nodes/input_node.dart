import 'dart:html' as html;

import 'package:dawn/src/nodes/user_input_node.dart';
import 'package:dawn/src/widgets/input.dart';

class InputNode extends UserInputNode<Input, html.InputElement> {
  InputNode({required super.widget, super.parentNode})
      : super(element: html.InputElement());

  @override
  void initializeElement() {
    super.initializeElement();

    element
      ..type = widget.type
      ..value = widget.value;
  }
}
