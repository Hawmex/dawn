import 'dart:html' as html;

import 'package:dawn/widgets.dart';

import 'framework_node.dart';

abstract class UserInputNode<T extends UserInputWidget, U extends html.Element>
    extends FrameworkNode<T, U> {
  UserInputNode({
    required super.widget,
    required super.element,
    super.parentNode,
  });

  @override
  void initializeElement() {
    super.initializeElement();
    addListener(type: 'change', listener: widget.onChange);
    addListener(type: 'input', listener: widget.onInput);
  }

  @override
  void disposeElement() {
    removeListener(type: 'change', listener: widget.onChange);
    removeListener(type: 'input', listener: widget.onInput);
    super.disposeElement();
  }
}
