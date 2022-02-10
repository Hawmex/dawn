// TODO: This needs reconsideration.

import 'package:dawn/src/foundation/core_widget.dart';
import 'package:dawn/src/foundation/widget.dart';

class Column extends CoreWidget {
  final List<Widget> children;

  const Column(this.children) : super();

  @override
  void paint() => print(children);
}
