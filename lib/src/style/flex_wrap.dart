enum FlexWrap {
  inherit('inherit'),
  initial('initial'),
  revert('revert'),
  revertLayer('revert-layer'),
  unset('unset'),

  wrap('wrap'),
  noWrap('nowrap');

  final String _value;

  const FlexWrap(this._value);

  @override
  String toString() => _value;
}
