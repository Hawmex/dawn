import 'dart:html' as html;

import 'package:dawn/style.dart';

import 'animation_direction.dart';
import 'animation_fill_mode.dart';

class Animation {
  final List<Style> keyframes;
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
    this.direction = AnimationDirection.forwards,
    this.fillMode = AnimationFillMode.none,
    this.iterations = 1,
  })  : assert(keyframes.length > 0),
        assert(iterations >= 1);

  html.Animation runOnElement(final html.Element element) {
    return element.animate(
      keyframes.map((final style) => style.toKeyframe()),
      {
        'duration': duration.inMilliseconds,
        'delay': startDelay.inMilliseconds,
        'endDelay': endDelay.inMilliseconds,
        'easing': easing.toString(),
        'direction': direction.toString(),
        'fill': fillMode.toString(),
        'iterations': iterations,
      },
    );
  }
}
