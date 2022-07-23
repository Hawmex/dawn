import 'dart:async';

import 'package:dawn/foundation.dart';

import 'provider.dart';
import 'stateful_widget.dart';
import 'widget.dart';

class ConsumerBuilder<T extends Store> extends StatefulWidget {
  final Widget Function(BuildContext context, T store) builder;

  const ConsumerBuilder(this.builder, {super.key});

  @override
  State createState() => _ConsumerBuilderState<T>();
}

class _ConsumerBuilderState<T extends Store> extends State<ConsumerBuilder<T>> {
  late final T store;
  late final StreamSubscription subscription;

  @override
  void initialize() {
    super.initialize();
    store = context.getProvidedStoreOfExactType<T>();
    subscription = store.onUpdate(() => setState(() {}));
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => widget.builder(context, store);
}
