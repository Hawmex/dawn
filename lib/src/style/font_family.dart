abstract class FontFamily {
  static const FontFamily initial = _Named('initial');
  static const FontFamily inherit = _Named('inherit');
  static const FontFamily unset = _Named('unset');
  static const FontFamily revert = _Named('revert');
  static const FontFamily revertLayer = _Named('revert-layer');

  static const FontFamily serif = _Named('serif');
  static const FontFamily sansSerif = _Named('sans-serif');
  static const FontFamily monospace = _Named('monospace');
  static const FontFamily cursive = _Named('cursive');
  static const FontFamily fantasy = _Named('fantasy');
  static const FontFamily systemUi = _Named('system-ui');
  static const FontFamily uiSerif = _Named('ui-serif');
  static const FontFamily uiSansSerif = _Named('ui-sans-serif');
  static const FontFamily uiMonospace = _Named('ui-monospace');
  static const FontFamily uiRounded = _Named('ui-rounded');
  static const FontFamily math = _Named('math');
  static const FontFamily emoji = _Named('emoji');
  static const FontFamily fangsong = _Named('fangsong');

  const factory FontFamily(final String name) = _Named;
}

class _Named with FontFamily {
  final String name;

  const _Named(this.name);

  @override
  String toString() => name;
}
