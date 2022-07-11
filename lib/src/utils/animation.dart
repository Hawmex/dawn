import 'package:dawn/src/utils.dart';

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
  /// Similar to that of JavaScript's `animate` API with the exception that
  /// kebab-case CSS properties should be used here (Unlike to JavaScript's
  /// `animate` API which uses camelCase CSS properties).
  final List<Map<String, String>> keyframes;

  /// Similar to that of JavaScript's `animate` API.
  final Map<String, dynamic>? options;

  const Animation({required this.keyframes, this.options});

  /// Transforms kebab-case CSS properties to their camelCase form.
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
