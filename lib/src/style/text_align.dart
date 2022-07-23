enum TextAlign {
  inherit('inherit'),
  initial('initial'),
  revert('revert'),
  revertLayer('revert-layer'),
  unset('unset'),

  start('start'),
  end('end'),
  left('left'),
  right('right'),
  center('center'),
  justify('justify'),
  justifyAll('justify-all'),
  matchParent('match-parent');

  final String _value;

  const TextAlign(this._value);

  @override
  String toString() => _value;
}
