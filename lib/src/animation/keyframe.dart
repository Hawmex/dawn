import 'package:dawn/foundation.dart';

import 'easing.dart';

class Keyframe {
  final double offset;
  final Style style;
  final Easing? easing;

  const Keyframe({required this.offset, required this.style, this.easing})
      : assert(offset >= 0 && offset <= 1);

  Map<String, String> toMap() {
    return {
      ...style.toKeyframeMap(),
      'offset': '$offset',
      if (easing != null) 'easing': '$easing'
    };
  }
}
