import 'dart:html' as html;

import 'package:dawn/src/nodes.dart';
import 'package:dawn/src/widgets.dart';

class InputNode extends UserInputNode<Input, html.InputElement> {
  InputNode(super.widget, {super.parentNode})
      : super(element: html.InputElement());

  @override
  void initializeElement() {
    super.initializeElement();
    element.type = widget.hideValue ? 'password' : 'text';
    element.value = widget.value;
  }
}
