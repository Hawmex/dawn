enum SelfAlignment {
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

  const SelfAlignment(this._value);

  @override
  String toString() => _value;
}
