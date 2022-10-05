import 'package:dawn/core.dart';

import 'inherited_widget.dart';

/// Provides the utility needed to depend on a [Store].
extension DependOnStore on BuildContext {
  /// Returns the first [Store] with the exact type [T] provided by the
  /// nearest parent [Provider].
  ///
  /// Also, if the [Provider] is updated, the widget owning this
  /// context is rebuilt.
  T dependOnProvidedStoreOfExactType<T extends Store>() => Provider.of(this)
      .stores
      .firstWhere((final store) => store.runtimeType == T) as T;
}

/// A widget that propagates multiple [Store] instances down the tree.
///
/// **Notice:** It is the developer that should handle the initialization and
/// disposal of stores by calling [Store.initialize] and [Store.dispose]
/// whenever it is necessary.
class Provider extends InheritedWidget {
  final List<Store> stores;

  /// Creates a new instance of [Provider].
  const Provider({required this.stores, required super.child, super.key});

  static Provider of(final BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Provider>();

  @override
  updateShouldNotify(final Provider oldWidget) => stores != oldWidget.stores;
}
