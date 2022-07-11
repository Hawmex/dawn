import 'package:dawn/src/utils.dart';

/// Use this class to declare styles for [FrameworkWidget] subclasses.
///
/// ```dart
/// const Text(
///   'Hello World!',
///   style: Style({
///     'color': 'red',
///     'font-weight': 'bold',
///   }),
/// );
/// ```
class Style {
  /// Each rule has a key as a CSS property and a corresponding value.
  final Map<String, String> rules;

  const Style(this.rules);

  /// The string representation of the declared CSS rules.
  @override
  String toString() => rules.isEmpty
      ? ''
      : rules.entries
          .map((final ruleEntry) => '${ruleEntry.key}: ${ruleEntry.value}')
          .join(';')
          .trimAll();
}
