import 'package:dawn/foundation.dart';

import 'inherited_widget.dart';

extension DependOnStore on BuildContext {
  /// Returns the first [Store] with the `runtimeType` equal
  /// to [T] provided by the closes [Provider].
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

  /// Creates a new [Provider] that propagates multiple [Store] instances down
  /// the tree.
  ///
  /// **Notice:** It is the developer that should handle the initialization and
  /// disposal of stores by calling [Store.initialize] and [Store.dispose]
  /// whenever it is necessary.
  const Provider({required this.stores, required super.child, super.key});

  factory Provider.of(final BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Provider>();

  @override
  shouldUpdateNotify(final Provider oldWidget) => stores != oldWidget.stores;
}
