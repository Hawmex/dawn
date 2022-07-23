import 'size.dart';

abstract class EdgeInsets {
  static const EdgeInsets initial = _Named('initial');
  static const EdgeInsets inherit = _Named('inherit');
  static const EdgeInsets unset = _Named('unset');
  static const EdgeInsets revert = _Named('revert');
  static const EdgeInsets revertLayer = _Named('revert-layer');

  const factory EdgeInsets.all(final Size size) = _Quantative.all;

  const factory EdgeInsets.only({
    final Size left,
    final Size top,
    final Size right,
    final Size bottom,
  }) = _Quantative.only;

  const factory EdgeInsets.symmetric({
    final Size vertical,
    final Size horizontal,
  }) = _Quantative.symmetric;

  const factory EdgeInsets.ltrb(
    final Size left,
    final Size top,
    final Size right,
    final Size bottom,
  ) = _Quantative.ltrb;
}

class _Named with EdgeInsets {
  final String name;

  const _Named(this.name);

  @override
  String toString() => name;
}

class _Quantative with EdgeInsets {
  final Size left;
  final Size top;
  final Size right;
  final Size bottom;

  const _Quantative.all(final Size size)
      : left = size,
        top = size,
        right = size,
        bottom = size;

  const _Quantative.only({
    this.left = Size.unset,
    this.top = Size.unset,
    this.right = Size.unset,
    this.bottom = Size.unset,
  });

  const _Quantative.symmetric({
    final Size vertical = Size.unset,
    final Size horizontal = Size.unset,
  })  : left = horizontal,
        top = vertical,
        right = horizontal,
        bottom = vertical;

  const _Quantative.ltrb(
    this.left,
    this.top,
    this.right,
    this.bottom,
  );

  @override
  String toString() => '$left $top $right $bottom';
}
