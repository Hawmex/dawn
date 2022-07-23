import 'package:dawn/widgets.dart';

import '../nodes/stateful_node.dart';
import '../nodes/stateless_node.dart';

void runApp(final Widget app) {
  if (app is StatelessWidget) {
    StatelessNode(widget: app).initialize();
  } else if (app is StatefulWidget) {
    StatefulNode(widget: app).initialize();
  } else {
    throw TypeError();
  }
}
