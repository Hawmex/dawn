import 'package:dawn/src/nodes.dart';
import 'package:dawn/src/widgets.dart';

Node createNode(final Widget widget, {final Node? parentNode}) {
  if (widget is StatelessWidget) {
    return StatelessNode(widget, parentNode: parentNode);
  } else if (widget is StatefulWidget) {
    return StatefulNode(widget, parentNode: parentNode);
  } else if (widget is Audio) {
    return AudioNode(widget, parentNode: parentNode);
  } else if (widget is Container) {
    return ContainerNode(widget, parentNode: parentNode);
  } else if (widget is Image) {
    return ImageNode(widget, parentNode: parentNode);
  } else if (widget is Input) {
    return InputNode(widget, parentNode: parentNode);
  } else if (widget is Text) {
    return TextNode(widget, parentNode: parentNode);
  } else if (widget is Textbox) {
    return TextBoxNode(widget, parentNode: parentNode);
  } else if (widget is Video) {
    return VideoNode(widget, parentNode: parentNode);
  } else {
    throw TypeError();
  }
}
