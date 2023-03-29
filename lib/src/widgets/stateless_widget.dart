import 'package:dawn/core.dart';

import 'widget.dart';

/// A [Widget] that does not have a mutable state.
abstract class StatelessWidget extends Widget with Buildable {
  const StatelessWidget({super.key, super.ref});

  @override
  StatelessNode createNode() => StatelessNode(this);
}

/// A [Node] corresponding to [StatelessWidget].
class StatelessNode<T extends StatelessWidget> extends SingleChildNode<T> {
  /// Creates a new instance of [StatelessNode].
  StatelessNode(super.widget);

  @override
  Widget get childWidget => widget.build(context);
}
