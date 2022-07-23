import 'angle.dart';
import 'transform.dart';

class Rotate with TransformFunction {
  final Angle x;
  final Angle y;
  final Angle z;

  const Rotate.all(final Angle value)
      : x = value,
        y = value,
        z = value;

  const Rotate.only({
    this.x = Angle.zero,
    this.y = Angle.zero,
    this.z = Angle.zero,
  });

  @override
  String toString() => 'rotate3d($x, $y, $z)';
}
