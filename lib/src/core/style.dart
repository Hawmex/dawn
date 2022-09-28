import 'case_transformable_string.dart';

class Style {
  final Map<String, String> _rules;

  const Style(this._rules);

  Map<String, String> toKeyframeMap() {
    return _rules.map(
      (final key, final value) => MapEntry(
        key.fromKebabCaseToCamelCase(),
        value,
      ),
    );
  }

  Style include(final Style? otherStyle) =>
      Style({..._rules, if (otherStyle != null) ...otherStyle._rules});

  @override
  String toString() => _rules.isEmpty
      ? ''
      : _rules.entries
          .map((final ruleEntry) => '${ruleEntry.key}: ${ruleEntry.value}')
          .join('; ')
          .trimAll();
}
