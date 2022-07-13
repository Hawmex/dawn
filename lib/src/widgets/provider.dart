import 'package:dawn/src/utils/context.dart';
import 'package:dawn/src/utils/store.dart';
import 'package:dawn/src/widgets/stateless_widget.dart';
import 'package:dawn/src/widgets/widget.dart';

/// Adds the functionality of getting a [Store] from [Context].
extension GetStore on Context {
  T getProvidedStoreOfExactType<T extends Store>() =>
      getParentWidgetOfExactType<Provider>()
          .stores
          .firstWhere((final store) => store.runtimeType == T) as T;
}

/// Provides a list of [Store]s to the [Context].
class Provider<T extends Store> extends StatelessWidget {
  final List<Store> stores;
  final Widget child;

  const Provider({required this.stores, required this.child, super.key});

  @override
  Widget build(final Context context) => child;
}
