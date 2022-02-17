import 'package:dawn/src/node.dart';
import 'package:dawn/src/widgets.dart';

class Context {
  final List<Node> _sequence;

  const Context(this._sequence);

  List<Node> get sequence => List.unmodifiable(_sequence);

  T getParentWidgetOfExactType<T extends Widget>() {
    return _sequence
        .firstWhere((final node) => node.widget.runtimeType == T)
        .widget as T;
  }
}
