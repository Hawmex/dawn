import 'package:dawn/src/utils/context.dart';
import 'package:dawn/src/widgets/widget.dart';

abstract class Node<T extends Widget> {
  final List<Node> parentsSequence;

  late final context =
      Context(parentsSequence.map((final node) => node.widget).toList());

  T _widget;

  Node({required final T widget, final Node? parentNode})
      : _widget = widget,
        parentsSequence = [
          if (parentNode != null) ...[parentNode, ...parentNode.parentsSequence]
        ];

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
