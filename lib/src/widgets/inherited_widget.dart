import 'dart:async';

import 'widget.dart';

abstract class InheritedWidget extends Widget {
  final Widget child;

  const InheritedWidget({required this.child, super.key});

  @override
  InheritedNode createNode() => InheritedNode(this);

  bool updateShouldNotify(covariant final InheritedWidget oldWidget);
}

class InheritedNode<T extends InheritedWidget> extends SingleChildNode<T> {
  late final StreamController<void> _updateStreamController;

  InheritedNode(super.widget);

  @override
  Widget get newChildWidget => widget.child;

  StreamSubscription<void> listen(final void Function() onUpdate) =>
      _updateStreamController.stream.listen((final event) => onUpdate());

  @override
  void initialize() {
    _updateStreamController = StreamController.broadcast();
    super.initialize();
  }

  @override
  void widgetDidUpdate(final T oldWidget) {
    super.widgetDidUpdate(oldWidget);
    if (widget.updateShouldNotify(oldWidget)) _updateStreamController.add(null);
  }

  @override
  void dispose() {
    super.dispose();
    _updateStreamController.close();
  }
}
