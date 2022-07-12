import 'package:dawn/src/widgets/widget.dart';

class Route {
  final String path;
  final Widget widget;
  final bool exact;

  const Route({
    required this.path,
    required this.widget,
    this.exact = false,
  });
}
