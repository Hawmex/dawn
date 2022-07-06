import 'dart:html' as html;

import 'package:dawn/src/widgets.dart';

/// The recommended type to use for event listeners in Dawn.
typedef EventListener = void Function(html.Event event);

/// The base class for Dawn framework widgets such as [Text], [Image],
/// [Container], etc.
abstract class FrameworkWidget extends Widget {
  final EventListener? onPointerDown;
  final EventListener? onPointerUp;
  final EventListener? onPointerEnter;
  final EventListener? onPointerLeave;
  final EventListener? onPress;
  final Style? style;
  final Animation? animation;

  const FrameworkWidget({
    this.onPointerDown,
    this.onPointerUp,
    this.onPointerEnter,
    this.onPointerLeave,
    this.onPress,
    this.style,
    this.animation,
    super.key,
  });
}

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
  final Map<String, String> rules;

  const Style(this.rules);

  @override
  String toString() => rules.isEmpty
      ? ''
      : rules.entries
          .map((final ruleEntry) => '${ruleEntry.key}: ${ruleEntry.value}')
          .join(';')
          .trimAll();
}

/// Use this class to declare an animation for [FrameworkWidget] subclasses.
///
/// ```dart
/// const Text(
///   'Hello World!',
///   animation: Animation(
///     keyframes: [
///       {'transform': 'rotate(0deg)'},
///       {'transform': 'rotate(360deg)'},
///     ],
///     options: {'duration': 300},
///   ),
/// );
/// ```
class Animation {
  final List<Map<String, String>> keyframes;
  final Map<String, dynamic>? options;

  const Animation({required this.keyframes, this.options});

  List<Map<String, String>> get keyframesForJsAnimation => keyframes
      .map(
        (final keyframe) => keyframe.map(
          (final key, final value) => MapEntry(
            key.fromKebabCaseToCamelCase(),
            value,
          ),
        ),
      )
      .toList();
}

extension StringTransforms on String {
  String toCapitalized() =>
      isEmpty ? '' : this[0].toUpperCase() + substring(1).toLowerCase();

  String trimAll() => replaceAll(RegExp(r'\s+'), ' ');

  String fromKebabCaseToCamelCase() {
    final parts = split('-');

    final words = parts
      ..removeWhere((final part) => part.isEmpty)
      ..map((final part) => part.toCapitalized()).toList();

    words.first = words.first.toLowerCase();

    return words.join();
  }
}
