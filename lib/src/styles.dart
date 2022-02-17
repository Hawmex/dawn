class Styles {
  final List<String> _rules;

  const Styles(this._rules);

  const Styles.empty() : _rules = const [];

  String get rules => _rules.isEmpty
      ? ''
      : _rules.reduce((final sum, final rule) => '$sum; $rule');
}
