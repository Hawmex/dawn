import 'package:dawn/src/widgets/widget.dart';

/// Contains a list of parent widgets in [sequence].
class Context {
  /// A list of parent widgets.
  final List<Widget> sequence;

  const Context(this.sequence);

  /// Returns the first parent widget in [sequence] which has the exact type of
  /// [T].
  T getParentWidgetOfExactType<T extends Widget>() =>
      sequence.firstWhere((final widget) => widget.runtimeType == T) as T;
}
