import 'package:dawn/src/nodes.dart';
import 'package:dawn/src/widgets.dart';

void runApp(final Widget app) {
  if (app is StatelessWidget) {
    StatelessNode(app).initialize();
  } else if (app is StatefulWidget) {
    StatefulNode(app).initialize();
  } else {
    throw TypeError();
  }
}
