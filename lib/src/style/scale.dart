import 'transform.dart';

class Scale with TransformFunction {
  final double x;
  final double y;
  final double z;

  const Scale.all(final double value)
      : x = value,
        y = value,
        z = value;

  const Scale.only({this.x = 1, this.y = 1, this.z = 1});

  @override
  String toString() => 'scale3d($x, $y, $z)';
}
