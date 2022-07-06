import 'package:dawn/src/nodes.dart';
import 'package:dawn/src/widgets.dart';

/// The base class for creating stateful widgets in Dawn.
abstract class StatefulWidget extends Widget {
  const StatefulWidget({super.key});

  /// Used to attach a [State] to a [StatefulWidget].
  State createState();
}
