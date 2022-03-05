part of dawn;

class Style {
  final Map<String, String> _rules;

  const Style(this._rules);
  const Style.empty() : _rules = const {};

  Map<String, String> get rules => Map.unmodifiable(_rules);

  @override
  String toString() => rules.isEmpty
      ? ''
      : rules.entries
          .map((final ruleEntry) => '${ruleEntry.key} : ${ruleEntry.value}')
          .reduce((final sum, final ruleString) => '$sum; $ruleString');
}
