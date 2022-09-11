import 'package:dawn/widgets.dart';

import 'async_snapshot.dart';
import 'build_context.dart';

/// The type of asynchronous builder function used in [FutureBuilder] and
/// [StreamBuilder].
typedef AsyncWidgetBuilder<T> = Widget Function(
  BuildContext context,
  AsyncSnapshot<T> snapshot,
);
