import 'package:dawn/src/utils.dart';
import 'package:dawn/src/widgets.dart';

/// The base class for creating stateless widgets in Dawn.
abstract class StatelessWidget extends Widget with Buildable {
  const StatelessWidget({super.key});
}
