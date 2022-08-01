import 'package:dawn/widgets.dart';

void runApp(final Widget app) => app.createNode()
  ..parentNode = null
  ..initialize();
