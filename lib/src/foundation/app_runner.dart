import 'package:dawn/widgets.dart';
import 'package:js/js.dart';

@JS('__dawnAppNode__')
external Node? _appNode;

/// Inflates the given widget and attaches it to the screen.
void runApp(final Widget app) {
  _appNode?.dispose();

  _appNode = app.createNode()
    ..parentNode = null
    ..initialize();
}
