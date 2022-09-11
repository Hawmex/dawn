import 'package:dawn/foundation.dart';

import 'stateful_widget.dart';
import 'widget.dart';

/// The type of function that updates a [State].
typedef StateSetter = void Function(void Function() callback);

/// The type of builder function used in [StatefulBuilder].
typedef StatefulWidgetBuilder = Widget Function(
  BuildContext context,
  StateSetter setState,
);

/// A  widget that both has state and calls a closure to obtain its child
/// widget.
class StatefulBuilder extends StatefulWidget {
  final StatefulWidgetBuilder builder;

  /// Creates a new [StatefulBuilder] that both has state and calls a closure to
  /// obtain its child widget.
  const StatefulBuilder(this.builder, {super.key});

  @override
  State createState() => _StatefulBuilderState();
}

class _StatefulBuilderState extends State<StatefulBuilder> {
  @override
  Widget build(final BuildContext context) => widget.builder(context, setState);
}
