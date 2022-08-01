import 'package:dawn/foundation.dart';

import 'inherited_widget.dart';

extension DependOnStore on BuildContext {
  T dependOnProvidedStoreOfExactType<T extends Store>() => Provider.of(this)
      .stores
      .firstWhere((final store) => store.runtimeType == T) as T;
}

class Provider extends InheritedWidget {
  final List<Store> stores;

  const Provider({required this.stores, required super.child, super.key});

  factory Provider.of(final BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Provider>();

  @override
  updateShouldNotify(final Provider oldWidget) => stores != oldWidget.stores;
}
