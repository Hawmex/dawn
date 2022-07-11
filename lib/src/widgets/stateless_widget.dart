import 'package:dawn/src/utils/buildable.dart';
import 'package:dawn/src/widgets/widget.dart';

/// The base class for creating stateless widgets in Dawn.
abstract class StatelessWidget extends Widget with Buildable {
  const StatelessWidget({super.key});
}
