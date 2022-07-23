import 'package:dawn/foundation.dart';

import 'stateless_widget.dart';
import 'widget.dart';

class StatelessBuilder extends StatelessWidget {
  final Widget Function(BuildContext context) builder;

  const StatelessBuilder(this.builder, {super.key});

  @override
  Widget build(final BuildContext context) => builder(context);
}
