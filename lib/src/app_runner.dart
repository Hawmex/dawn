import 'package:dawn/src/nodes.dart';
import 'package:dawn/src/widgets.dart';

/// Initializes a Dawn application.
///
/// [app] must be a [StatefulWidget] or [StatelessWidget].
void runApp(final Widget app) {
  if (app is StatelessWidget) {
    StatelessNode(app).initialize();
  } else if (app is StatefulWidget) {
    StatefulNode(app).initialize();
  } else {
    throw TypeError();
  }
}
