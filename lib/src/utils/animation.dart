part of dawn;

class Animation {
  final List<Map<String, String>> keyframes;
  final Map<String, dynamic>? options;

  const Animation({required this.keyframes, this.options});

  static String _kebabToCamel(final String text) {
    final parts = text
        .split('-')
        .map(
          (final part) =>
              part.isEmpty ? '' : part[0].toUpperCase() + part.substring(1),
        )
        .toList();

    final newText = parts.join();

    return newText[0].toLowerCase() + newText.substring(1);
  }

  List<Map<String, String>> get keyframesForJsAnimation => keyframes
      .map(
        (final keyframe) => keyframe.map(
          (final key, final value) => MapEntry(_kebabToCamel(key), value),
        ),
      )
      .toList();
}
