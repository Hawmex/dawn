import 'package:dawn/src/foundation/context.dart';
import 'package:dawn/src/foundation/widget.dart';

abstract class Buildable {
  List<Widget> build(final Context context);
}
