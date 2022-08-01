import 'dart:async';

import 'package:dawn/foundation.dart';

import 'provider.dart';
import 'stateful_widget.dart';
import 'widget.dart';

typedef ConsumerWidgetBuilder<T extends Store> = Widget Function(
  BuildContext context,
  T store,
);

class ConsumerBuilder<T extends Store> extends StatefulWidget {
  final ConsumerWidgetBuilder<T> builder;

  const ConsumerBuilder(this.builder, {super.key});

  @override
  State createState() => _ConsumerBuilderState<T>();
}

class _ConsumerBuilderState<T extends Store> extends State<ConsumerBuilder<T>> {
  late T store;
  late StreamSubscription subscription;

  @override
  void initialize() {
    super.initialize();
    store = context.dependOnProvidedStoreOfExactType<T>();
    subscription = store.listen(() => setState(() {}));
  }

  @override
  void didDependenciesUpdate() {
    super.didDependenciesUpdate();
    subscription.cancel();
    store = context.dependOnProvidedStoreOfExactType<T>();
    subscription = store.listen(() => setState(() {}));
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => widget.builder(context, store);
}
