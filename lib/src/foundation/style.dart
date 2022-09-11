import 'dart:html' as html;

import 'package:dawn/widgets.dart';

import 'string_transforms.dart';

/// Describes how a [PaintedWidget] should look on the screens.
class Style {
  final Map<String, String> _rules;

  /// Creates a new [Style] that describes how a [PaintedWidget] should look on
  /// the screens.
  const Style(this._rules);

  /// Returns a map that can be used by [html.Element.animate].
  Map<String, String> toKeyframeMap() {
    return _rules.map(
      (final key, final value) => MapEntry(
        key.fromKebabCaseToCamelCase(),
        value,
      ),
    );
  }

  /// Concatenates two styles.
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
