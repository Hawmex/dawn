import 'package:dawn/core.dart';

import 'consumer_widget.dart';
import 'widget.dart';

/// The type of the builder function used in a [ConsumerBuilder].
typedef ConsumerWidgetBuilder<T extends Store> = Widget Function(
  BuildContext context,
  T store,
);

/// A widget that is rebuilt with the latest state of a [Store] provided by a
/// [Provider].
class ConsumerBuilder<T extends Store> extends ConsumerWidget<T> {
  final ConsumerWidgetBuilder<T> builder;

  /// Creates a new instance of [ConsumerBuilder].
  const ConsumerBuilder(this.builder, {super.key, super.ref});

  @override
  Widget build(final BuildContext context, final T store) =>
      builder(context, store);
}
