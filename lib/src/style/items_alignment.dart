enum ItemsAlignment {
  inherit('inherit'),
  initial('initial'),
  revert('revert'),
  revertLayer('revert-layer'),
  unset('unset'),

  normal('normal'),
  stretch('stretch'),
  center('center'),
  start('start'),
  end('end');

  final String _value;

  const ItemsAlignment(this._value);

  @override
  String toString() => _value;
}
