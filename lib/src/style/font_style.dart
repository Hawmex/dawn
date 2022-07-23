import 'angle.dart';

abstract class FontStyle {
  static const FontStyle initial = _Named('initial');
  static const FontStyle inherit = _Named('inherit');
  static const FontStyle unset = _Named('unset');
  static const FontStyle revert = _Named('revert');
  static const FontStyle revertLayer = _Named('revert-layer');

  static const FontStyle normal = _Named('normal');
  static const FontStyle italic = _Named('italic');
  static const FontStyle oblique = _Named('oblique');

  const factory FontStyle.obliqueWithAngle({
    required final Angle angle,
  }) = _ObliqueWithAngle;
}

class _Named with FontStyle {
  final String name;

  const _Named(this.name);

  @override
  String toString() => name;
}

class _ObliqueWithAngle with FontStyle {
  final Angle angle;

  const _ObliqueWithAngle({required this.angle});

  @override
  String toString() => 'oblique $angle';
}
