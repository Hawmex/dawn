import 'dart:html' as html;

import 'package:dawn/animation.dart';
import 'package:dawn/foundation.dart';
import 'package:dawn/style.dart';

import 'widget.dart';

abstract class FrameworkWidget extends Widget {
  final Style? style;
  final Animation? animation;

  final EventListener<html.MouseEvent>? onPress;

  final EventListener<html.PointerEvent>? onPointerDown;
  final EventListener<html.PointerEvent>? onPointerUp;
  final EventListener<html.PointerEvent>? onPointerEnter;
  final EventListener<html.PointerEvent>? onPointerLeave;
  final EventListener<html.PointerEvent>? onPointerMove;
  final EventListener<html.PointerEvent>? onPointerCancel;
  final EventListener<html.PointerEvent>? onPointerOver;
  final EventListener<html.PointerEvent>? onPointerOut;

  final EventListener<html.MouseEvent>? onMouseDown;
  final EventListener<html.MouseEvent>? onMouseUp;
  final EventListener<html.MouseEvent>? onMouseEnter;
  final EventListener<html.MouseEvent>? onMouseLeave;
  final EventListener<html.MouseEvent>? onMouseMove;
  final EventListener<html.MouseEvent>? onMouseOver;
  final EventListener<html.MouseEvent>? onMouseOut;

  final EventListener<html.TouchEvent>? onTouchStart;
  final EventListener<html.TouchEvent>? onTouchEnd;
  final EventListener<html.TouchEvent>? onTouchMove;
  final EventListener<html.TouchEvent>? onTouchCancel;

  const FrameworkWidget({
    this.style,
    this.animation,
    this.onPress,
    this.onPointerDown,
    this.onPointerUp,
    this.onPointerEnter,
    this.onPointerLeave,
    this.onPointerMove,
    this.onPointerCancel,
    this.onPointerOver,
    this.onPointerOut,
    this.onMouseDown,
    this.onMouseUp,
    this.onMouseEnter,
    this.onMouseLeave,
    this.onMouseMove,
    this.onMouseOver,
    this.onMouseOut,
    this.onTouchStart,
    this.onTouchEnd,
    this.onTouchMove,
    this.onTouchCancel,
    super.key,
  });
}
