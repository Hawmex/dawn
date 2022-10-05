import 'package:dawn/widgets.dart';

import 'build_context.dart';

/// Adds the [build] function to classes such as [StatelessWidget] and [State].
mixin Buildable {
  /// Returns a single widget with the given [context].
  Widget build(final BuildContext context);
}
