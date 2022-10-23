import 'dart:html' as html;
import 'painted_widget.dart';
import 'widget.dart';

class TextField extends PaintedWidget {
  final String textId;
  final String placeHolder;
  const TextField(this.textId, this.placeHolder, {super.style});

  @override
  TextFieldNode createNode() => TextFieldNode(this);
}

class TextFieldNode
    extends ChildlessPaintedNode<TextField, html.TextInputElement> {
  TextFieldNode(super.widget) : super(element: html.TextInputElement());

  @override
  void initializeElement() {
    super.initializeElement();

    element.id = widget.textId;
    element.placeholder = widget.placeHolder;
  }
}
