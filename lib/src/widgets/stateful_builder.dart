import 'package:dawn/src/nodes/stateful_node.dart';
import 'package:dawn/src/utils/context.dart';
import 'package:dawn/src/widgets/stateful_widget.dart';
import 'package:dawn/src/widgets/widget.dart';

/// A type to declare state setter functions.
typedef StateSetter = void Function(void Function() callback);

/// A widget that rebuilds its content everytime `setState` is called.
class StatefulBuilder extends StatefulWidget {
  final Widget Function(Context context, StateSetter setState) builder;

  const StatefulBuilder(this.builder, {super.key});

  @override
  State createState() => _StatefulBuilderState();
}

class _StatefulBuilderState extends State<StatefulBuilder> {
  @override
  Widget build(final Context context) => widget.builder(context, setState);
}
