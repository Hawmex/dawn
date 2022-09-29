import 'package:dawn/widgets.dart';
import 'package:js/js.dart';

@JS('__dawnAppNode__')
external Node? _appNode;

void runApp(final Widget app) {
  print(r'''
   _____     __          ___   _ 
  |  __ \   /\ \        / / \ | |
  | |  | | /  \ \  /\  / /|  \| |
  | |  | |/ /\ \ \/  \/ / | . ` |
  | |__| / ____ \  /\  /  | |\  |
  |_____/_/    \_\/  \/   |_| \_|                                                         
''');

  _appNode?.dispose();

  _appNode = app.createNode()
    ..parentNode = null
    ..initialize();
}
