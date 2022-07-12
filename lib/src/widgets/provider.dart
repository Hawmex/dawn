import 'package:dawn/src/utils/context.dart';
import 'package:dawn/src/utils/store.dart';
import 'package:dawn/src/widgets/stateless_widget.dart';
import 'package:dawn/src/widgets/widget.dart';

extension GetStore on Context {
  T getProvidedStoreOfExactType<T extends Store>() =>
      getParentWidgetOfExactType<Provider<T>>().store;
}

class Provider<T extends Store> extends StatelessWidget {
  final T store;
  final Widget child;

  const Provider(this.store, this.child, {super.key});

  @override
  Widget build(final Context context) => child;
}
