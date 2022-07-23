import 'size.dart';

abstract class BorderRadius {
  static const BorderRadius initial = _Named('initial');
  static const BorderRadius inherit = _Named('inherit');
  static const BorderRadius unset = _Named('unset');
  static const BorderRadius revert = _Named('revert');
  static const BorderRadius revertLayer = _Named('revert-layer');

  const factory BorderRadius.all(final Radius radius) = _Quantative.all;

  const factory BorderRadius.horizontal({
    final Radius left,
    final Radius right,
  }) = _Quantative.horizontal;

  const factory BorderRadius.vertical({
    final Radius top,
    final Radius bottom,
  }) = _Quantative.vertical;

  const factory BorderRadius.only({
    final Radius topLeft,
    final Radius topRight,
    final Radius bottomRight,
    final Radius bottomLeft,
  }) = _Quantative.only;

  Map<String, String> toMap();
}

class _Named with BorderRadius {
  final String name;

  const _Named(this.name);

  @override
  Map<String, String> toMap() => {'border-radius': name};
}

class Radius {
  static const Radius zero = Radius.circular(Size.zero);

  final Size x;
  final Size y;

  const Radius.circular(final Size size)
      : x = size,
        y = size;

  const Radius.elliptical(this.x, this.y);

  @override
  String toString() => '$x $y';
}

class _Quantative with BorderRadius {
  final Radius topLeft;
  final Radius topRight;
  final Radius bottomRight;
  final Radius bottomLeft;

  const _Quantative.all(final Radius radius)
      : topLeft = radius,
        topRight = radius,
        bottomRight = radius,
        bottomLeft = radius;

  const _Quantative.horizontal({
    final Radius left = Radius.zero,
    final Radius right = Radius.zero,
  })  : topLeft = left,
        topRight = right,
        bottomRight = right,
        bottomLeft = left;

  const _Quantative.vertical({
    final Radius top = Radius.zero,
    final Radius bottom = Radius.zero,
  })  : topLeft = top,
        topRight = top,
        bottomRight = bottom,
        bottomLeft = bottom;

  const _Quantative.only({
    this.topRight = Radius.zero,
    this.topLeft = Radius.zero,
    this.bottomRight = Radius.zero,
    this.bottomLeft = Radius.zero,
  });

  @override
  Map<String, String> toMap() {
    return {
      'border-top-left-radius': '$topLeft',
      'border-top-right-radius': '$topRight',
      'border-bottom-right-radius': '$bottomRight',
      'border-bottom-left-radius': '$bottomLeft',
    };
  }
}
