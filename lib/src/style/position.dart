import 'edge_insets.dart';

abstract class Position {
  static const Position initial = _Named('initial');
  static const Position inherit = _Named('inherit');
  static const Position unset = _Named('unset');
  static const Position revert = _Named('revert');
  static const Position revertLayer = _Named('revert-layer');

  static const Position static = _Named('static');
  static const Position relative = _Named('relative');
  static const Position absolute = _Named('absolute');
  static const Position fixed = _Named('fixed');
  static const Position sticky = _Named('sticky');

  const factory Position.relativeWithInset(final EdgeInsets inset) =
      _WithInset.relative;

  const factory Position.absoluteWithInset(final EdgeInsets inset) =
      _WithInset.absolute;

  const factory Position.fixedWithInset(final EdgeInsets inset) =
      _WithInset.fixed;

  const factory Position.stickyWithInset(final EdgeInsets inset) =
      _WithInset.sticky;

  Map<String, String> toMap();
}

class _Named with Position {
  final String name;

  const _Named(this.name);

  @override
  Map<String, String> toMap() => {'position': name};
}

class _WithInset with Position {
  final String name;
  final EdgeInsets inset;

  const _WithInset.relative(this.inset) : name = 'relative';
  const _WithInset.absolute(this.inset) : name = 'relative';
  const _WithInset.fixed(this.inset) : name = 'relative';
  const _WithInset.sticky(this.inset) : name = 'relative';

  @override
  Map<String, String> toMap() => {'position': name, 'inset': '$inset'};
}
