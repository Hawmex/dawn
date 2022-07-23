import 'size.dart';
import 'transform.dart';

class Translate with TransformFunction {
  final Size x;
  final Size y;
  final Size z;

  const Translate.all(final Size value)
      : x = value,
        y = value,
        z = value;

  const Translate.only({
    this.x = Size.zero,
    this.y = Size.zero,
    this.z = Size.zero,
  });

  @override
  String toString() => 'translate3d($x, $y, $z)';
}
