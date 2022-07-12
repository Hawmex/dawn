import 'dart:html' as html;

import 'package:dawn/src/nodes/stateful_node.dart';
import 'package:dawn/src/utils/context.dart';
import 'package:dawn/src/utils/navigator.dart';
import 'package:dawn/src/utils/route.dart';
import 'package:dawn/src/widgets/stateful_widget.dart';
import 'package:dawn/src/widgets/widget.dart';
import 'package:path_to_regexp/path_to_regexp.dart';

class Router extends StatefulWidget {
  final Set<Route> routes;

  const Router(this.routes, {super.key});

  @override
  State createState() => _RouterState();
}

class _RouterState extends State<Router> {
  late Route matchingRoute;

  void match([final html.Event? event]) {
    setState(() {
      matchingRoute = widget.routes.firstWhere((final route) {
        final parameters = <String>[];

        final regExp = pathToRegExp(
          route.path,
          parameters: parameters,
          prefix: !route.exact,
        );

        final match = regExp.matchAsPrefix(Navigator.path);

        if (match != null) {
          Navigator.parameters
            ..clear()
            ..addAll(extract(parameters, match));

          return true;
        } else {
          return false;
        }
      });
    });
  }

  @override
  void initialize() {
    super.initialize();
    match();
    html.window.addEventListener('hashchange', match);
  }

  @override
  void dispose() {
    html.window.removeEventListener('hashchange', match);
    super.dispose();
  }

  @override
  Widget build(final Context context) => matchingRoute.builder(context);
}
