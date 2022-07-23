enum UserSelect {
  inherit('inherit'),
  initial('initial'),
  revert('revert'),
  revertLayer('revert-layer'),
  unset('unset'),

  none('none'),
  auto('auto'),
  text('text'),
  contain('contain'),
  all('all');

  final String _value;

  const UserSelect(this._value);

  @override
  String toString() => _value;
}
