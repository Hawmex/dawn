import 'package:dawn/foundation.dart';

import 'stateless_widget.dart';
import 'widget.dart';

/// The type of builder function used in [StatelessBuilder].
typedef StatelessWidgetBuilder = Widget Function(BuildContext context);

/// A stateless utility widget whose build method uses its builder callback to
/// create the widget's child.
class StatelessBuilder extends StatelessWidget {
  final StatelessWidgetBuilder builder;

  /// Creates a new [StatelessBuilder] whose build method uses its builder
  /// callback to create the widget's child.
  const StatelessBuilder(this.builder, {super.key});

  @override
  Widget build(final BuildContext context) => builder(context);
}
