import 'package:dawn/core.dart';

import 'easing.dart';

/// Similar to CSS and JS animations' keyframes.
///
/// Each keyframe has an [offset], a [style], and an [easing] property.
class Keyframe {
  final double offset;
  final Style style;
  final Easing? easing;

  /// Creates a new [Keyframe] instance.
  const Keyframe({required this.offset, required this.style, this.easing});

  /// Returns a [Map] representation of this [Keyframe].
  Map<String, String> toMap() {
    return {
      ...style.toKeyframeMap(),
      'offset': '$offset',
      if (easing != null) 'easing': '$easing'
    };
  }
}
