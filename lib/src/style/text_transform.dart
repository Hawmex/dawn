enum TextTransform {
  inherit('inherit'),
  initial('initial'),
  revert('revert'),
  revertLayer('revert-layer'),
  unset('unset'),

  none('none'),
  capitalize('capitalize'),
  upperCase('uppercase'),
  lowerCase('lowercase'),
  fullWidth('full-width'),
  fullSizeKana('full-size-kana');

  final String _value;

  const TextTransform(this._value);

  @override
  String toString() => _value;
}
