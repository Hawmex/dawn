import 'string_transforms.dart';

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

  Style include(final Style? style) =>
      Style({..._rules, if (style != null) ...style._rules});

  @override
  String toString() => _rules.isEmpty
      ? ''
      : _rules.entries
          .map((final ruleEntry) => '${ruleEntry.key}: ${ruleEntry.value}')
          .join('; ')
          .trimAll();
}
