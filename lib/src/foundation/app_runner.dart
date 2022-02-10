// TODO: Find a way to properly start and run an app.

import 'package:dawn/src/foundation/context.dart';
import 'package:dawn/src/foundation/core_widget.dart';
import 'package:dawn/src/foundation/stateful_widget.dart';
import 'package:dawn/src/foundation/stateless_widget.dart';
import 'package:dawn/src/foundation/widget.dart';

void _runWidget(final Widget widget) {
  if (widget is StatelessWidget) {
    widget.build(Context()).forEach(_runWidget);
  } else if (widget is StatefulWidget) {
    final state = widget.createState()
      ..context = Context()
      ..widget = widget
      ..initialize();

    state.build(state.context).forEach(_runWidget);

    state.didMount();
  } else if (widget is CoreWidget) {
    widget.paint();
  } else {
    throw TypeError();
  }
}

void runApp(final Widget app) => _runWidget(app);
