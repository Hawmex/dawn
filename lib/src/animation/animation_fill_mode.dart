enum AnimationFillMode {
  forwards('forwards'),
  backwards('backwards'),
  none('none'),
  both('both');

  final String _value;

  const AnimationFillMode(this._value);

  @override
  String toString() => _value;
}
