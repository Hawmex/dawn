import 'dart:async';

import 'package:dawn/core.dart';

import 'provider.dart';
import 'stateful_widget.dart';
import 'widget.dart';

/// A base class for widgets that are rebuilt with the latest state of a [Store]
/// provided by a [Provider].
abstract class ConsumerWidget<T extends Store> extends StatefulWidget {
  const ConsumerWidget({super.key, super.ref});

  Widget build(final BuildContext context, final T store);

  @override
  State createState() => _ConsumerWidgetState<T>();
}

class _ConsumerWidgetState<T extends Store> extends State<ConsumerWidget<T>> {
  late T _store;
  late StreamSubscription<void> _subscription;

  @override
  void initialize() {
    super.initialize();
    _store = context.dependOnProvidedStoreOfExactType<T>();
    _subscription = _store.listen(() => setState(() {}));
  }

  @override
  void dependenciesDidUpdate() {
    super.dependenciesDidUpdate();
    _subscription.cancel();
    _store = context.dependOnProvidedStoreOfExactType<T>();
    _subscription = _store.listen(() => setState(() {}));
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => widget.build(context, _store);
}
