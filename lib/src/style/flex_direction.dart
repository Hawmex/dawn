enum FlexDirection {
  inherit('inherit'),
  initial('initial'),
  revert('revert'),
  revertLayer('revert-layer'),
  unset('unset'),

  row('row'),
  rowReverse('row-reverse'),
  column('column'),
  columnReverse('column-reverse');

  final String _value;

  const FlexDirection(this._value);

  @override
  String toString() => _value;
}
