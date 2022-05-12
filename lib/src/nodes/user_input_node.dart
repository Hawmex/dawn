import 'dart:html' as html;

import 'package:dawn/src/widgets.dart';

import 'framework_node.dart';

abstract class UserInputNode<T extends UserInputWidget, U extends html.Element>
    extends FrameworkNode<T, U> {
  UserInputNode(
    final super._widget, {
    required final super.element,
    final super.parentNode,
  });

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
