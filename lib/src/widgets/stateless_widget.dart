import 'package:dawn/core.dart';

import 'widget.dart';

abstract class StatelessWidget extends Widget with Buildable {
  const StatelessWidget({super.key});

  @override
  StatelessNode createNode() => StatelessNode(this);
}

class StatelessNode<T extends StatelessWidget> extends SingleChildNode<T> {
  StatelessNode(super.widget);

  @override
  Widget get newChildWidget => widget.build(context);
}
