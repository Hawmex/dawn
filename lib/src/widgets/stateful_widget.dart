import 'package:dawn/foundation.dart';

import 'widget.dart';

abstract class StatefulWidget extends Widget {
  const StatefulWidget({super.key});

  State createState();
}
