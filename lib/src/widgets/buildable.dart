import 'package:dawn/src/widgets.dart';

/// A mixin to implement [build] for [StatelessWidget], etc.
mixin Buildable {
  Widget build(final Context context);
}

/// Contains a list of parent widgets in [sequence].
class Context {
  final List<Widget> sequence;

  const Context(this.sequence);

  T getParentWidgetOfExactType<T extends Widget>() =>
      sequence.firstWhere((final widget) => widget.runtimeType == T) as T;
}
