abstract class FontWeight {
  static const FontWeight initial = _Named('initial');
  static const FontWeight inherit = _Named('inherit');
  static const FontWeight unset = _Named('unset');
  static const FontWeight revert = _Named('revert');
  static const FontWeight revertLayer = _Named('revert-layer');

  static const FontWeight normal = _Named('normal');
  static const FontWeight bold = _Named('bold');
  static const FontWeight lighter = _Named('lighter');
  static const FontWeight bolder = _Named('bolder');

  const factory FontWeight(final int weight) = _Quantative;
}

class _Named with FontWeight {
  final String name;

  const _Named(this.name);

  @override
  String toString() => name;
}

class _Quantative with FontWeight {
  final int weight;

  const _Quantative(this.weight) : assert(weight > 0 && weight < 1000);

  @override
  String toString() => '$weight';
}
