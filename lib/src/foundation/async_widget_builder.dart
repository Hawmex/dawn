import 'package:dawn/widgets.dart';

import 'async_snapshot.dart';
import 'build_context.dart';

typedef AsyncWidgetBuilder<T> = Widget Function(
  BuildContext context,
  AsyncSnapshot<T> snapshot,
);
