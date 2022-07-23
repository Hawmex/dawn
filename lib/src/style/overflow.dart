enum Overflow {
  inherit('inherit'),
  initial('initial'),
  revert('revert'),
  revertLayer('revert-layer'),
  unset('unset'),

  visible('visible'),
  hidden('hidden'),
  clip('clip'),
  scroll('scroll'),
  auto('auto');

  final String _value;

  const Overflow(this._value);

  @override
  String toString() => _value;
}
