import 'package:dawn/src/utils/context.dart';
import 'package:dawn/src/widgets/stateless_widget.dart';
import 'package:dawn/src/widgets/widget.dart';

/// A widget that statelessly builds its content.
class StatelessBuilder extends StatelessWidget {
  final Widget Function(Context context) builder;

  const StatelessBuilder(this.builder, {super.key});

  @override
  Widget build(final Context context) => builder(context);
}
