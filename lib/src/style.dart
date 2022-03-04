class Style {
  final Map<String, String> _rules;

  const Style(this._rules);
  const Style.empty() : _rules = const {};

  Map<String, String> get rules => Map.unmodifiable(_rules);

  String get rulesString => rules.isEmpty
      ? ''
      : rules.entries
          .map((final ruleEntry) => '${ruleEntry.key} : ${ruleEntry.value}')
          .reduce((final sum, final ruleString) => '$sum; $ruleString');
}
