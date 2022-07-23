extension SizeConversion on num {
  Size get cm => Size.cm(toDouble());
  Size get mm => Size.mm(toDouble());
  Size get inch => Size.inch(toDouble());
  Size get px => Size.px(toDouble());
  Size get pt => Size.pt(toDouble());
  Size get pc => Size.pc(toDouble());
  Size get em => Size.em(toDouble());
  Size get ex => Size.ex(toDouble());
  Size get ch => Size.ch(toDouble());
  Size get rem => Size.rem(toDouble());
  Size get vw => Size.vw(toDouble());
  Size get vh => Size.vh(toDouble());
  Size get vmin => Size.vmin(toDouble());
  Size get vmax => Size.vmax(toDouble());
  Size get percent => Size.percent(toDouble());
  Size get fr => Size.fr(toDouble());
}

abstract class Size {
  static const Size initial = _Named('initial');
  static const Size inherit = _Named('inherit');
  static const Size unset = _Named('unset');
  static const Size revert = _Named('revert');
  static const Size revertLayer = _Named('revert-layer');

  static const Size auto = _Named('auto');
  static const Size minContent = _Named('min-content');
  static const Size maxContent = _Named('max-content');

  static const Size zero = Size.px(0);

  const factory Size.cm(final double size) = _Quantative.cm;
  const factory Size.mm(final double size) = _Quantative.mm;
  const factory Size.inch(final double size) = _Quantative.inch;
  const factory Size.px(final double size) = _Quantative.px;
  const factory Size.pt(final double size) = _Quantative.pt;
  const factory Size.pc(final double size) = _Quantative.pc;
  const factory Size.em(final double size) = _Quantative.em;
  const factory Size.ex(final double size) = _Quantative.ex;
  const factory Size.ch(final double size) = _Quantative.ch;
  const factory Size.rem(final double size) = _Quantative.rem;
  const factory Size.vw(final double size) = _Quantative.vw;
  const factory Size.vh(final double size) = _Quantative.vh;
  const factory Size.vmin(final double size) = _Quantative.vmin;
  const factory Size.vmax(final double size) = _Quantative.vmax;
  const factory Size.percent(final double size) = _Quantative.percent;
  const factory Size.fr(final double size) = _Quantative.fr;
}

class _Named with Size {
  final String name;

  const _Named(this.name);

  @override
  String toString() => name;
}

class _Quantative with Size {
  final double size;
  final String unit;

  const _Quantative.cm(this.size) : unit = 'cm';
  const _Quantative.mm(this.size) : unit = 'mm';
  const _Quantative.inch(this.size) : unit = 'in';
  const _Quantative.px(this.size) : unit = 'px';
  const _Quantative.pt(this.size) : unit = 'pt';
  const _Quantative.pc(this.size) : unit = 'pc';
  const _Quantative.em(this.size) : unit = 'em';
  const _Quantative.ex(this.size) : unit = 'ex';
  const _Quantative.ch(this.size) : unit = 'ch';
  const _Quantative.rem(this.size) : unit = 'rem';
  const _Quantative.vw(this.size) : unit = 'vw';
  const _Quantative.vh(this.size) : unit = 'vh';
  const _Quantative.vmin(this.size) : unit = 'vmin';
  const _Quantative.vmax(this.size) : unit = 'vmax';
  const _Quantative.percent(this.size) : unit = '%';
  const _Quantative.fr(this.size) : unit = 'fr';

  @override
  String toString() => '$size$unit';
}
