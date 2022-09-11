import 'dart:async';

import 'widget.dart';

/// The base class for widgets that efficiently propagate information down the
/// tree.
abstract class InheritedWidget extends Widget {
  final Widget child;

  const InheritedWidget({required this.child, super.key});

  @override
  InheritedNode createNode() => InheritedNode(this);

  /// Whether [Node.updateSubtree] should be called on dependent nodes after
  /// this widget is updated.
  bool shouldUpdateNotify(covariant final InheritedWidget oldWidget);
}

class InheritedNode extends Node<InheritedWidget> {
  /// The child of this [Node] in the tree.
  late Node childNode;

  late final StreamController<void> _updateStreamController;

  InheritedNode(super.widget);

  /// Listens to this [InheritedWidget] to get notified when it's updated.
  StreamSubscription<void> listen(final void Function() onUpdate) =>
      _updateStreamController.stream.listen((final event) => onUpdate());

  @override
  void updateSubtree() {
    final newChildWidget = widget.child;

    if (newChildWidget.matches(childNode.widget)) {
      childNode.widget = newChildWidget;
    } else {
      childNode.dispose();

      childNode = newChildWidget.createNode()
        ..parentNode = this
        ..initialize();
    }
  }

  @override
  void initialize() {
    super.initialize();

    _updateStreamController = StreamController.broadcast();

    childNode = widget.child.createNode()
      ..parentNode = this
      ..initialize();
  }

  @override
  void didWidgetUpdate(final InheritedWidget oldWidget) {
    super.didWidgetUpdate(oldWidget);
    if (widget.shouldUpdateNotify(oldWidget)) _updateStreamController.add(null);
  }

  @override
  void dispose() {
    childNode.dispose();
    _updateStreamController.close();
    super.dispose();
  }
}
