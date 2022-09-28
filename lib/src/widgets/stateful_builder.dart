import 'package:dawn/core.dart';

import 'stateful_widget.dart';
import 'widget.dart';

typedef StateSetter = void Function(void Function() callback);

typedef StatefulWidgetBuilder = Widget Function(
  BuildContext context,
  StateSetter setState,
);

class StatefulBuilder extends StatefulWidget {
  final StatefulWidgetBuilder builder;

  const StatefulBuilder(this.builder, {super.key});

  @override
  State createState() => _StatefulBuilderState();
}

class _StatefulBuilderState extends State<StatefulBuilder> {
  @override
  Widget build(final BuildContext context) => widget.builder(context, setState);
}
