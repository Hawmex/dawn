import 'dart:html' as html;

import 'package:dawn/src/utils.dart';
import 'package:dawn/src/widgets.dart';

/// Use this class to declare an animation for [FrameworkWidget] subclasses.
class Animation {
  final List<Style> keyframes;
  final Duration duration;
  final Duration startDelay;
  final Duration endDelay;
  final Easing easing;
  final AnimationDirection direction;
  final AnimationFill fill;
  final double iterations;

  const Animation(
    this.keyframes, {
    this.duration = Duration.zero,
    this.startDelay = Duration.zero,
    this.endDelay = Duration.zero,
    this.easing = const Easing.linear(),
    this.direction = AnimationDirection.forwards,
    this.fill = AnimationFill.none,
    this.iterations = 1,
  });

  html.Animation runOnElement(final html.Element element) {
    return element.animate(
      keyframes.map((final style) => style.toKeyframe()),
      {
        'duration': duration.inMilliseconds,
        'delay': startDelay.inMilliseconds,
        'endDelay': endDelay.inMilliseconds,
        'easing': easing.toString(),
        'direction': direction.name,
        'fill': fill.name,
        'iterations': iterations,
      },
    );
  }
}

class Easing {
  final double x1;
  final double y1;
  final double x2;
  final double y2;

  const Easing.cubicBezier(this.x1, this.y1, this.x2, this.y2);

  const Easing.linear()
      : x1 = 0,
        y1 = 0,
        x2 = 1,
        y2 = 1;

  const Easing.ease()
      : x1 = 0.25,
        y1 = 0.1,
        x2 = 0.25,
        y2 = 1;

  const Easing.easeIn()
      : x1 = 0.42,
        y1 = 0,
        x2 = 1,
        y2 = 1;

  const Easing.easeOut()
      : x1 = 0,
        y1 = 0,
        x2 = 0.58,
        y2 = 1;

  const Easing.easeInAndOut()
      : x1 = 0.42,
        y1 = 0,
        x2 = 0.58,
        y2 = 1;

  @override
  String toString() => 'cubic-bezier($x1, $y1, $x2, $y2)';
}

enum AnimationDirection {
  forwards('normal'),
  backwards('reverse'),
  forwardsAlternating('alternate'),
  backwardsAlternating('alternate-reverse');

  final String name;

  const AnimationDirection(this.name);
}

enum AnimationFill {
  forwards('forwards'),
  backwards('backwards'),
  none('none'),
  both('both');

  final String name;

  const AnimationFill(this.name);
}
