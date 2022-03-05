part of dawn;

typedef Sequence = List<Node<Widget>>;

class Context {
  final Sequence _sequence;

  const Context(this._sequence);
  const Context.empty() : _sequence = const [];

  Sequence get sequence => List.unmodifiable(_sequence);

  T getParentWidgetOfExactType<T extends Widget>() =>
      sequence.firstWhere((final node) => node.widget.runtimeType == T).widget
          as T;
}
