import 'package:dawn/src/foundation/buildable.dart';
import 'package:dawn/src/foundation/context.dart';
import 'package:dawn/src/foundation/widget.dart';

abstract class StatefulWidget extends Widget {
  const StatefulWidget() : super();

  State<StatefulWidget> createState();
}

abstract class State<T extends StatefulWidget> implements Buildable {
  late final T widget;
  late final Context context;

  bool _isMounted = false;

  bool get isMounted => _isMounted;

  void initialize() {}
  void didMount() => _isMounted = true;
  void didUpdate() => build(context);
  void dispose() => _isMounted = false;

  void setState(final void Function() callback) {
    callback();
    if (isMounted) didUpdate();
  }
}
