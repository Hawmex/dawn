enum AnimationDirection {
  forwards('normal'),
  backwards('reverse'),
  forwardsThenAlternating('alternate'),
  backwardsThenAlternating('alternate-reverse');

  final String _value;

  const AnimationDirection(this._value);

  @override
  String toString() => _value;
}
