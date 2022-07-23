import 'package:dawn/foundation.dart';
import 'package:dawn/widgets.dart';

import 'audio_node.dart';
import 'container_node.dart';
import 'image_node.dart';
import 'input_node.dart';
import 'stateful_node.dart';
import 'stateless_node.dart';
import 'text_area_node.dart';
import 'text_node.dart';
import 'video_node.dart';

abstract class Node<T extends Widget> {
  static Node create({required final Widget widget, final Node? parentNode}) {
    if (widget is StatelessWidget) {
      return StatelessNode(widget: widget, parentNode: parentNode);
    } else if (widget is StatefulWidget) {
      return StatefulNode(widget: widget, parentNode: parentNode);
    } else if (widget is Audio) {
      return AudioNode(widget: widget, parentNode: parentNode);
    } else if (widget is Container) {
      return ContainerNode(widget: widget, parentNode: parentNode);
    } else if (widget is Image) {
      return ImageNode(widget: widget, parentNode: parentNode);
    } else if (widget is Input) {
      return InputNode(widget: widget, parentNode: parentNode);
    } else if (widget is Text) {
      return TextNode(widget: widget, parentNode: parentNode);
    } else if (widget is TextArea) {
      return TextAreaNode(widget: widget, parentNode: parentNode);
    } else if (widget is Video) {
      return VideoNode(widget: widget, parentNode: parentNode);
    } else {
      throw TypeError();
    }
  }

  final Node? _parentNode;

  late final BuildContext context = BuildContext(node: this);

  T _widget;

  Node({required final T widget, final Node? parentNode})
      : _widget = widget,
        _parentNode = parentNode;

  bool get isRootNode => parentNodes.isEmpty;

  List<Node> get parentNodes {
    if (_parentNode == null) {
      return [];
    } else {
      return [_parentNode!, ..._parentNode!.parentNodes];
    }
  }

  T get widget => _widget;

  set widget(final T newWidget) {
    if (widget != newWidget) {
      final oldWidget = _widget;

      willWidgetUpdate(newWidget);
      _widget = newWidget;
      didWidgetUpdate(oldWidget);
    }
  }

  void initialize() {}
  void willWidgetUpdate(final T newWidget) {}
  void didWidgetUpdate(final T oldWidget) {}
  void dispose() {}
}
