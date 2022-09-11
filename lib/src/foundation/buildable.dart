import 'package:dawn/widgets.dart';

import 'build_context.dart';

/// A mixin to add the building functionality to [StatelessWidget] and [State].
mixin Buildable {
  /// Describes the part of the user interface represented by this widget.
  Widget build(final BuildContext context);
}
