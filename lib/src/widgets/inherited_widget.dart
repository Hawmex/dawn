import 'dart:async';

import 'package:dawn/foundation.dart';

import 'widget.dart';

abstract class InheritedWidget extends Widget {
  final Widget child;

  const InheritedWidget({required this.child, super.key});

  @override
  InheritedNode createNode() => InheritedNode(this);

  bool shouldUpdateNotify(covariant final InheritedWidget oldWidget);
}

class InheritedNode extends Node<InheritedWidget> {
  late Node childNode;
  late StreamController<void> _updateStreamController;

  InheritedNode(super.widget);

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
