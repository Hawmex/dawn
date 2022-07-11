import 'package:dawn/src/utils/context.dart';
import 'package:dawn/src/widgets/widget.dart';

/// A mixin to implement [build] for [StatelessWidget], etc.
mixin Buildable {
  /// Returns the UI content to be painted on the screen.
  Widget build(final Context context);
}
