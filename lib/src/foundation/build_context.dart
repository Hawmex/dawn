import 'package:dawn/widgets.dart';

/// Represents the location of a widget in the tree.
class BuildContext {
  final Node _node;

  /// Creates a new [BuildContext] for its owner [Node].
  const BuildContext(this._node);

  /// Returns the closest parent [InheritedWidget] with the `runtimeType` equal
  /// to [T].
  ///
  /// Also, if the [InheritedWidget] is updated, the widget owning this
  /// context is rebuilt.
  T dependOnInheritedWidgetOfExactType<T extends InheritedWidget>() =>
      _node.dependOnInheritedWidgetOfExactType<T>();
}
