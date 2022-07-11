import 'package:dawn/src/utils.dart';
import 'package:dawn/src/widgets.dart';

/// A mixin to implement [build] for [StatelessWidget], etc.
mixin Buildable {
  /// Returns the UI content to be painted on the screen.
  Widget build(final Context context);
}
