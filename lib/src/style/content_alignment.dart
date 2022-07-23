enum ContentAlignment {
  inherit('inherit'),
  initial('initial'),
  revert('revert'),
  revertLayer('revert-layer'),
  unset('unset'),

  normal('normal'),
  stretch('stretch'),
  center('center'),
  start('start'),
  end('end'),
  spaceAround('space-around'),
  spaceBetween('space-between'),
  spaceEvenly('space-evenly');

  final String _value;

  const ContentAlignment(this._value);

  @override
  String toString() => _value;
}
