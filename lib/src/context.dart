import 'package:dawn/src/nodes.dart';
import 'package:dawn/src/widgets.dart';

typedef Sequence = List<Node<Widget>>;

class Context {
  final Sequence _sequence;

  const Context(this._sequence);
  const Context.empty() : _sequence = const [];

  Sequence get sequence => List.unmodifiable(_sequence);

  T getParentWidgetOfExactType<T extends Widget>() =>
      _sequence.firstWhere((final node) => node.widget.runtimeType == T).widget
          as T;
}
