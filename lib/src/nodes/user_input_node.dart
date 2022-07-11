import 'dart:html' as html;

import 'package:dawn/src/nodes/framework_node.dart';
import 'package:dawn/src/widgets/user_input_widget.dart';

abstract class UserInputNode<T extends UserInputWidget, U extends html.Element>
    extends FrameworkNode<T, U> {
  UserInputNode(super.widget, {required super.element, super.parentNode});

  @override
  void initializeElement() {
    super.initializeElement();

    element
      ..addEventListener('change', widget.onChange)
      ..addEventListener('input', widget.onInput);
  }

  @override
  void disposeElement() {
    element
      ..removeEventListener('change', widget.onChange)
      ..removeEventListener('input', widget.onInput);

    super.disposeElement();
  }
}
