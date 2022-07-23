abstract class Easing {
  static const Easing initial = _Named('initial');
  static const Easing inherit = _Named('inherit');
  static const Easing unset = _Named('unset');
  static const Easing revert = _Named('revert');
  static const Easing revertLayer = _Named('revert-layer');

  static const Easing linear = _Named('linear');
  static const Easing ease = _Named('ease');
  static const Easing easeIn = _Named('ease-in');
  static const Easing easeOut = _Named('ease-out');
  static const Easing easeInAndOut = _Named('ease-in-out');

  const factory Easing.cubicBezier(
    final double x1,
    final double y1,
    final double x2,
    final double y2,
  ) = _CubicBezier;
}

class _Named with Easing {
  final String name;

  const _Named(this.name);

  @override
  String toString() => name;
}

class _CubicBezier with Easing {
  final double x1;
  final double y1;
  final double x2;
  final double y2;

  const _CubicBezier(this.x1, this.y1, this.x2, this.y2)
      : assert(x1 >= 0 && x1 <= 1),
        assert(y1 >= 0 && y1 <= 1),
        assert(x2 >= 0 && x2 <= 1),
        assert(y2 >= 0 && y2 <= 1);

  @override
  String toString() => 'cubic-bezier($x1, $y1, $x2, $y2)';
}
