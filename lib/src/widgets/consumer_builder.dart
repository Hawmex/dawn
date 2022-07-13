import 'dart:async';

import 'package:dawn/src/nodes/stateful_node.dart';
import 'package:dawn/src/utils/context.dart';
import 'package:dawn/src/utils/store.dart';
import 'package:dawn/src/widgets/provider.dart';
import 'package:dawn/src/widgets/stateful_widget.dart';
import 'package:dawn/src/widgets/widget.dart';

class ConsumerBuilder<T extends Store> extends StatefulWidget {
  final Widget Function(Context context, T store) builder;

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
  Widget build(final Context context) => widget.builder(context, store);
}
