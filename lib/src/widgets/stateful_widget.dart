import 'package:dawn/src/nodes/stateful_node.dart';
import 'package:dawn/src/widgets/widget.dart';

/// The base class for creating stateful widgets in Dawn.
abstract class StatefulWidget extends Widget {
  const StatefulWidget({super.key});

  /// Used to attach a [State] to a [StatefulWidget].
  State createState();
}
