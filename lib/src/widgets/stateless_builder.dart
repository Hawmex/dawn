import 'package:dawn/foundation.dart';

import 'stateless_widget.dart';
import 'widget.dart';

typedef StatelessWidgetBuilder = Widget Function(BuildContext context);

class StatelessBuilder extends StatelessWidget {
  final StatelessWidgetBuilder builder;

  const StatelessBuilder(this.builder, {super.key});

  @override
  Widget build(final BuildContext context) => builder(context);
}
