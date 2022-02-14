import 'package:dawn/src/core/components.dart';

class Context {
  final List<Component> _sequence;

  const Context(this._sequence);

  List<Component> get sequence => List.unmodifiable(_sequence);

  T getParentOfExactType<T extends Component>() {
    return sequence.firstWhere(
      (final component) => component.runtimeType == T,
    ) as T;
  }
}
