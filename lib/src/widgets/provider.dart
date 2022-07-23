import 'package:dawn/foundation.dart';

import 'stateless_widget.dart';
import 'widget.dart';

extension GetStore on BuildContext {
  T getProvidedStoreOfExactType<T extends Store>() =>
      getParentWidgetOfExactType<Provider>()
          .stores
          .firstWhere((final store) => store.runtimeType == T) as T;
}

class Provider<T extends Store> extends StatelessWidget {
  final List<Store> stores;
  final Widget child;

  const Provider({required this.stores, required this.child, super.key});

  @override
  Widget build(final BuildContext context) => child;
}
