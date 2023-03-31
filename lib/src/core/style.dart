import 'package:dawn/widgets.dart';

import 'string_helpers.dart';

/// Describes how a [PaintedWidget] should look on the screens.
class Style {
  final Map<String, String> _rules;

  /// Creates a new instance of [Style].
  const Style(this._rules);

  /// Returns a map representation of this [Style] that can be used by
  /// JavaScript's animation API.
  Map<String, String> toKeyframeMap() {
    return _rules.map(
      (final key, final value) => MapEntry(
        key.fromKebabCaseToCamelCase(),
        value,
      ),
    );
  }

  /// Concatenates two styles.
  Style operator +(final Style? otherStyle) =>
      Style({..._rules, if (otherStyle != null) ...otherStyle._rules});

  /// Concatenates two styles.
  Style addAll(final Style? otherStyle) => this + otherStyle;

  @override
  String toString() => _rules.isEmpty
      ? ''
      : _rules.entries
          .map((final ruleEntry) => '${ruleEntry.key}: ${ruleEntry.value}')
          .join('; ')
          .trimAll();
}
