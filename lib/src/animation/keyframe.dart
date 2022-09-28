import 'package:dawn/core.dart';

import 'easing.dart';

class Keyframe {
  final double offset;
  final Style style;
  final Easing? easing;

  const Keyframe({required this.offset, required this.style, this.easing});

  Map<String, String> toMap() {
    return {
      ...style.toKeyframeMap(),
      'offset': '$offset',
      if (easing != null) 'easing': '$easing'
    };
  }
}
