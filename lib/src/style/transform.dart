class TransformFunction {}

class Transform {
  static const Transform initial = _Named('initial');
  static const Transform inherit = _Named('inherit');
  static const Transform unset = _Named('unset');
  static const Transform revert = _Named('revert');
  static const Transform revertLayer = _Named('revert-layer');

  const factory Transform(final List<TransformFunction> transformFunctions) =
      _List;
}

class _Named with Transform {
  final String _value;

  const _Named(this._value);

  @override
  String toString() => _value;
}

class _List with Transform {
  final List<TransformFunction> transformFunctions;

  const _List(this.transformFunctions);

  @override
  String toString() => transformFunctions
      .map((final transformFunction) => '$transformFunction')
      .join(', ');
}
