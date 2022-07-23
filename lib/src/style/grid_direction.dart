enum GridDirection {
  inherit('inherit'),
  initial('initial'),
  revert('revert'),
  revertLayer('revert-layer'),
  unset('unset'),

  row('row'),
  column('column'),
  denseRow('row dense'),
  denseColumn('column dense');

  final String _value;

  const GridDirection(this._value);

  @override
  String toString() => _value;
}
