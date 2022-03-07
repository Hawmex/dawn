part of dawn;

class Style {
  final Map<String, String> rules;

  const Style(this.rules);

  @override
  String toString() => rules.isEmpty
      ? ''
      : rules.entries
          .map((final ruleEntry) => '${ruleEntry.key}: ${ruleEntry.value}')
          .reduce((final sum, final ruleString) => '$sum; $ruleString');
}
