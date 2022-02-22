class Styles {
  final List<String> _rules;

  const Styles(this._rules);
  const Styles.empty() : _rules = const [];

  List<String> get rules => List.unmodifiable(_rules);

  String get rulesString => rules.isEmpty
      ? ''
      : rules.reduce((final sum, final rule) => '$sum; $rule');
}
