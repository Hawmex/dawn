import 'package:dawn/core.dart';

import 'stateful_widget.dart';
import 'widget.dart';

/// The type of the function that updates a [State].
typedef StateSetter = void Function(void Function() callback);

/// The type of the builder function used in a [StatefulBuilder].
typedef StatefulWidgetBuilder = Widget Function(
  BuildContext context,
  StateSetter setState,
);

/// A widget that has a [State] and calls a closure to obtain its child
/// widget.
class StatefulBuilder extends StatefulWidget {
  final StatefulWidgetBuilder builder;

  /// Creates a new instance of [StatefulBuilder].
  const StatefulBuilder(this.builder, {super.key});

  @override
  State createState() => _StatefulBuilderState();
}

class _StatefulBuilderState extends State<StatefulBuilder> {
  @override
  Widget build(final BuildContext context) => widget.builder(context, setState);
}
