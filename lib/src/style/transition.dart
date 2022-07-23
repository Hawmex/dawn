import 'transition_declaration.dart';

class Transition {
  static const Transition initial = _Named('initial');
  static const Transition inherit = _Named('inherit');
  static const Transition unset = _Named('unset');
  static const Transition revert = _Named('revert');
  static const Transition revertLayer = _Named('revert-layer');

  const factory Transition(
    final List<TransitionDeclaration> transitionDeclarations,
  ) = _List;
}

class _Named with Transition {
  final String _value;

  const _Named(this._value);

  @override
  String toString() => _value;
}

class _List with Transition {
  final List<TransitionDeclaration> transitionDeclarations;

  const _List(this.transitionDeclarations);

  @override
  String toString() => transitionDeclarations
      .map((final transitionDeclaration) => '$transitionDeclaration')
      .join(', ');
}
