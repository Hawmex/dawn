import 'package:dawn/widgets.dart';

/// The location of a specific [Widget] in the [Node] tree.
class BuildContext {
  final Node _node;

  const BuildContext(this._node);

  /// Returns the nearest [InheritedWidget] with the exact type [T]. If [T] is
  /// updated, the part of the [Node] tree with this context is rebuilt.
  ///
  /// Also, if the [Node] owning this context is a [StatefulNode],
  /// [State.dependenciesDidUpdate] will be called.
  T dependOnInheritedWidgetOfExactType<T extends InheritedWidget>() =>
      _node.dependOnInheritedWidgetOfExactType<T>();
}
