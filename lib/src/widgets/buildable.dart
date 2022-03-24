import 'widget.dart';

mixin Buildable {
  Widget build(final Context context);
}

class Context {
  final List<Widget> sequence;

  const Context(this.sequence);

  T getParentWidgetOfExactType<T extends Widget>() =>
      sequence.firstWhere((final widget) => widget.runtimeType == T) as T;
}
