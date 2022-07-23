extension AngleConversion on num {
  Angle get deg => Angle.deg(toDouble());
  Angle get grad => Angle.grad(toDouble());
  Angle get rad => Angle.rad(toDouble());
  Angle get turn => Angle.turn(toDouble());
}

class Angle {
  static const Angle zero = Angle.deg(0);

  final double size;
  final String unit;

  const Angle.deg(this.size) : unit = 'deg';
  const Angle.grad(this.size) : unit = 'grad';
  const Angle.rad(this.size) : unit = 'rad';
  const Angle.turn(this.size) : unit = 'turn';

  @override
  String toString() => '$size$unit';
}
