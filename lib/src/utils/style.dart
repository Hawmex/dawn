import 'package:dawn/src/utils/string_transforms.dart';
import 'package:dawn/src/widgets/framework_widget.dart';

/// Use this class to declare styles for [FrameworkWidget] subclasses.
class Style {
  /// Each rule has a key as a CSS property and a corresponding value.
  final Map<String, String> rules;

  const Style(this.rules);

  /// The keyframe representation of the declared CSS rules.
  Map<String, String> toKeyframe() => rules.map((final key, final value) =>
      MapEntry(key.fromKebabCaseToCamelCase(), value));

  @override
  String toString() => rules.isEmpty
      ? ''
      : rules.entries
          .map((final ruleEntry) => '${ruleEntry.key}: ${ruleEntry.value}')
          .join('; ')
          .trimAll();
}
