import 'package:dawn/src/nodes/audio_node.dart';
import 'package:dawn/src/nodes/container_node.dart';
import 'package:dawn/src/nodes/image_node.dart';
import 'package:dawn/src/nodes/input_node.dart';
import 'package:dawn/src/nodes/node.dart';
import 'package:dawn/src/nodes/stateful_node.dart';
import 'package:dawn/src/nodes/stateless_node.dart';
import 'package:dawn/src/nodes/text_node.dart';
import 'package:dawn/src/nodes/textbox_node.dart';
import 'package:dawn/src/nodes/video_node.dart';
import 'package:dawn/src/widgets/audio.dart';
import 'package:dawn/src/widgets/container.dart';
import 'package:dawn/src/widgets/image.dart';
import 'package:dawn/src/widgets/input.dart';
import 'package:dawn/src/widgets/stateful_widget.dart';
import 'package:dawn/src/widgets/stateless_widget.dart';
import 'package:dawn/src/widgets/text.dart';
import 'package:dawn/src/widgets/textbox.dart';
import 'package:dawn/src/widgets/video.dart';
import 'package:dawn/src/widgets/widget.dart';

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
