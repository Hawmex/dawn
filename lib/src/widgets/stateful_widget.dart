import 'package:dawn/src/nodes.dart';
import 'package:dawn/src/widgets.dart';

abstract class StatefulWidget extends Widget {
  const StatefulWidget({super.key});

  State createState();
}
