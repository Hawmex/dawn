import 'dart:html' as html;

import 'animation_direction.dart';
import 'animation_fill_mode.dart';
import 'easing.dart';
import 'keyframe.dart';

class Animation {
  final List<Keyframe> keyframes;
  final Duration duration;
  final Duration startDelay;
  final Duration endDelay;
  final Easing easing;
  final AnimationDirection direction;
  final AnimationFillMode fillMode;
  final double iterations;

  const Animation({
    required this.keyframes,
    this.duration = Duration.zero,
    this.startDelay = Duration.zero,
    this.endDelay = Duration.zero,
    this.easing = Easing.linear,
    this.direction = AnimationDirection.normal,
    this.fillMode = AnimationFillMode.none,
    this.iterations = 1,
  });

  /// Applies this [Animation] to the given [element].
  html.Animation runOnElement(final html.Element element) {
    return element.animate(
      keyframes.map((final keyframe) => keyframe.toMap()),
      {
        'duration': duration.inMilliseconds,
        'delay': startDelay.inMilliseconds,
        'endDelay': endDelay.inMilliseconds,
        'easing': '$easing',
        'direction': '$direction',
        'fill': '$fillMode',
        'iterations': iterations,
      },
    );
  }
}
