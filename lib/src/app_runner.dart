import 'package:dawn/src/nodes/stateful_node.dart';
import 'package:dawn/src/nodes/stateless_node.dart';
import 'package:dawn/src/widgets/stateful_widget.dart';
import 'package:dawn/src/widgets/stateless_widget.dart';
import 'package:dawn/src/widgets/widget.dart';

/// Initializes a Dawn application.
///
/// [app] must be a [StatefulWidget] or [StatelessWidget].
void runApp(final Widget app) {
  if (app is StatelessWidget) {
    StatelessNode(widget: app).initialize();
  } else if (app is StatefulWidget) {
    StatefulNode(widget: app).initialize();
  } else {
    throw TypeError();
  }
}
