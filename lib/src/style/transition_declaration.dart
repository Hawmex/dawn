import 'easing.dart';
import 'transition_property.dart';

class TransitionDeclaration {
  final TransitionProperty property;
  final Duration duration;
  final Easing easing;
  final Duration delay;

  const TransitionDeclaration({
    required this.property,
    required this.duration,
    this.easing = Easing.linear,
    this.delay = Duration.zero,
  });

  @override
  String toString() => '$property $duration $easing $delay';
}
