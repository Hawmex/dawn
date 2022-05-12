import 'dart:html' as html;

import 'widget.dart';

typedef EventListener = void Function(html.Event event);

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
    final super.key,
  });
}

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
