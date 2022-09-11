import 'dart:async';

import 'package:dawn/foundation.dart';

import 'provider.dart';
import 'stateful_widget.dart';
import 'widget.dart';

/// The type of builder function used in [ConsumerBuilder].
typedef ConsumerWidgetBuilder<T extends Store> = Widget Function(
  BuildContext context,
  T store,
);

/// A widget that is rebuilt with the latest state of a [Store] provided by a
/// [Provider].
class ConsumerBuilder<T extends Store> extends StatefulWidget {
  final ConsumerWidgetBuilder<T> builder;

  /// Creates a new [ConsumerBuilder] which is a widget that is rebuilt with the
  /// latest state of a [Store] provided by a [Provider].
  const ConsumerBuilder(this.builder, {super.key});

  @override
  State createState() => _ConsumerBuilderState<T>();
}

class _ConsumerBuilderState<T extends Store> extends State<ConsumerBuilder<T>> {
  late T _store;
  late StreamSubscription _subscription;

  @override
  void initialize() {
    super.initialize();
    _store = context.dependOnProvidedStoreOfExactType<T>();
    _subscription = _store.listen(() => setState(() {}));
  }

  @override
  void didDependenciesUpdate() {
    super.didDependenciesUpdate();
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
  Widget build(final BuildContext context) => widget.builder(context, _store);
}
