import 'package:dawn/widgets.dart';

import 'async_snapshot.dart';
import 'build_context.dart';

/// The type of the builder function used in async builders such as
/// [StreamBuilder] and [FutureBuilder].
typedef AsyncWidgetBuilder<T> = Widget Function(
  BuildContext context,
  AsyncSnapshot<T> snapshot,
);
