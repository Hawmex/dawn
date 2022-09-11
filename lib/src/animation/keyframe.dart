import 'dart:html' as html;

import 'package:dawn/foundation.dart';

import 'easing.dart';

/// An implementation similar to CSS keyframes.
class Keyframe {
  final double offset;
  final Style style;
  final Easing? easing;

  /// Creates a new [Keyframe] that has [offset], [style], and [easing] similar
  /// to CSS animations.
  const Keyframe({required this.offset, required this.style, this.easing});

  /// Returns a map that can be used by [html.Element.animate].
  Map<String, String> toMap() {
    return {
      ...style.toKeyframeMap(),
      'offset': '$offset',
      if (easing != null) 'easing': '$easing'
    };
  }
}
