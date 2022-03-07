part of dawn;

typedef Sequence = List<Node<Widget>>;

class Context {
  final Sequence sequence;

  const Context(this.sequence);
  const Context.empty() : sequence = const [];

  T getParentWidgetOfExactType<T extends Widget>() =>
      sequence.firstWhere((final node) => node.widget.runtimeType == T).widget
          as T;
}
