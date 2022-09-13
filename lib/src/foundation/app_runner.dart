import 'dart:html' as html;

import 'package:dawn/widgets.dart';
import 'package:js/js.dart';

@JS('__dawnAppNode__')
external Node? _appNode;

/// Inflates the given widget and attaches it to the screen.
void runApp(final Widget app) {
  print(r'''
   _____     __          ___   _ 
  |  __ \   /\ \        / / \ | |
  | |  | | /  \ \  /\  / /|  \| |
  | |  | |/ /\ \ \/  \/ / | . ` |
  | |__| / ____ \  /\  /  | |\  |
  |_____/_/    \_\/  \/   |_| \_|                                                         
''');

  html.document.head!.append(
    html.document.createElement('script')
      ..text = '''
window.__dawnAddEventListener__ = function (
  target,
  type,
  listener,
  useCapture
) {
  target.addEventListener(type, listener, useCapture);
};

window.__dawnRemoveEventListener__ = function (
  target,
  type,
  listener,
  useCapture
) {
  target.removeEventListener(type, listener, useCapture);
};
''',
  );

  _appNode?.dispose();

  _appNode = app.createNode()
    ..parentNode = null
    ..initialize();
}
