import 'package:dawn/src/nodes.dart';

import 'widget.dart';

abstract class StatefulWidget extends Widget {
  const StatefulWidget({final String? key}) : super(key: key);

  State<StatefulWidget> createState();
}
