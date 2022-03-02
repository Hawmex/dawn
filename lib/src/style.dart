class Style {
  final List<String> _rules;

  const Style(this._rules);
  const Style.empty() : _rules = const [];

  List<String> get rules => List.unmodifiable(_rules);

  String get rulesString => rules.isEmpty
      ? ''
      : rules.reduce((final sum, final rule) => '$sum; $rule');
}
