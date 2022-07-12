import 'package:dawn/src/utils/context.dart';
import 'package:dawn/src/widgets/widget.dart';

class Route {
  final String path;
  final Widget Function(Context context) builder;
  final bool exact;

  const Route({
    required this.path,
    required this.builder,
    this.exact = false,
  });
}
