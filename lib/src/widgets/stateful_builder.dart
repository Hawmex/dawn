import 'package:dawn/foundation.dart';

import 'stateful_widget.dart';
import 'widget.dart';

typedef StateSetter = void Function(void Function() callback);

class StatefulBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, StateSetter setState) builder;

  const StatefulBuilder(this.builder, {super.key});

  @override
  State createState() => _StatefulBuilderState();
}

class _StatefulBuilderState extends State<StatefulBuilder> {
  @override
  Widget build(final BuildContext context) => widget.builder(context, setState);
}
