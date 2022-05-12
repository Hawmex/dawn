import 'package:dawn/src/nodes.dart';

import 'widget.dart';

abstract class StatefulWidget extends Widget {
  const StatefulWidget({final super.key});

  State createState();
}
