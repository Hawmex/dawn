enum TransitionProperty {
  all('all'),
  inset('inset'),
  position('position'),
  display('display'),
  minWidth('min-width'),
  minHeight('min-height'),
  width('width'),
  height('height'),
  maxWidth('max-width'),
  maxHeight('max-height'),
  padding('padding'),
  margin('margin'),
  backgroundColor('background-color'),
  borderRadius('border-radius'),
  fontFamily('font-family'),
  fontSize('font-size'),
  fontStyle('font-style'),
  fontWeight('font-weight'),
  textAlign('text-align'),
  textColor('color'),
  textTransform('text-transform'),
  userSelect('user-select'),
  overflowX('overflow-x'),
  overflowY('overflow-y'),
  opacity('opacity'),
  transform('transform');

  final String _value;

  const TransitionProperty(this._value);

  @override
  String toString() => _value;
}
