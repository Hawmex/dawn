import 'package:dawn/foundation.dart';

import 'border_radius.dart';
import 'color.dart';
import 'display.dart';
import 'edge_insets.dart';
import 'font_family.dart';
import 'font_style.dart';
import 'font_weight.dart';
import 'overflow.dart';
import 'position.dart';
import 'size.dart';
import 'text_align.dart';
import 'text_transform.dart';
import 'transform.dart';
import 'transition.dart';
import 'user_select.dart';

abstract class Style {
  const factory Style({
    final Position position,
    final Display display,
    final Size minWidth,
    final Size minHeight,
    final Size width,
    final Size height,
    final Size maxWidth,
    final Size maxHeight,
    final EdgeInsets padding,
    final EdgeInsets margin,
    final Color backgroundColor,
    final BorderRadius borderRadius,
    final FontFamily fontFamily,
    final Size fontSize,
    final FontStyle fontStyle,
    final FontWeight fontWeight,
    final TextAlign textAlign,
    final Color textColor,
    final TextTransform textTransform,
    final UserSelect userSelect,
    final Overflow overflowX,
    final Overflow overflowY,
    final double opacity,
    final Transform transform,
    final Transition transition,
    final Color accentColor,
  }) = _Style;

  const factory Style.raw(final Map<String, String> rules) = _Raw;

  factory Style.combined(final List<Style> styles) => Style.raw(styles
      .map((final style) => style.toMap())
      .reduce((final rules, final map) => {...rules, ...map}));

  Map<String, String> toMap();

  Map<String, String> toKeyframe() => toMap().map((final key, final value) =>
      MapEntry(key.fromKebabCaseToCamelCase(), value));

  Style combineWith(final Style style) => Style.combined([this, style]);

  @override
  String toString() {
    final map = toMap();

    if (map.isEmpty) {
      return '';
    } else {
      return map.entries
          .map((final entry) => '${entry.key}: ${entry.value}')
          .join('; ')
          .trimAll();
    }
  }
}

class _Style with Style {
  final Position? position;
  final Display? display;

  final Size? minWidth;
  final Size? minHeight;
  final Size? width;
  final Size? height;
  final Size? maxWidth;
  final Size? maxHeight;

  final EdgeInsets? padding;
  final EdgeInsets? margin;

  final Color? backgroundColor;

  final BorderRadius? borderRadius;

  final FontFamily? fontFamily;
  final Size? fontSize;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;

  final TextAlign? textAlign;
  final Color? textColor;
  final TextTransform? textTransform;

  final UserSelect? userSelect;

  final Overflow? overflowX;
  final Overflow? overflowY;

  final double? opacity;

  final Transform? transform;

  final Transition? transition;

  final Color? accentColor;

  const _Style({
    this.position,
    this.display,
    this.minWidth,
    this.minHeight,
    this.width,
    this.height,
    this.maxWidth,
    this.maxHeight,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.fontFamily,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.textAlign,
    this.textColor,
    this.textTransform,
    this.userSelect,
    this.overflowX,
    this.overflowY,
    this.opacity,
    this.transform,
    this.transition,
    this.accentColor,
  }) : assert(opacity == null ? true : opacity >= 0 && opacity <= 1);

  @override
  Map<String, String> toMap() {
    return {
      if (position != null) ...position!.toMap(),
      if (display != null) ...display!.toMap(),
      if (minWidth != null) 'min-width': '$minWidth',
      if (minHeight != null) 'min-height': '$minHeight',
      if (width != null) 'width': '$width',
      if (height != null) 'height': '$height',
      if (maxWidth != null) 'max-width': '$maxWidth',
      if (maxHeight != null) 'max-height': '$maxHeight',
      if (padding != null) 'padding': '$padding',
      if (margin != null) 'margin': '$margin',
      if (backgroundColor != null) 'background-color': '$backgroundColor',
      if (borderRadius != null) ...borderRadius!.toMap(),
      if (fontFamily != null) 'font-family': '$fontFamily',
      if (fontSize != null) 'font-size': '$fontSize',
      if (fontStyle != null) 'font-style': '$fontStyle',
      if (fontWeight != null) 'font-weight': '$fontWeight',
      if (textAlign != null) 'text-align': '$textAlign',
      if (textColor != null) 'color': '$textColor',
      if (textTransform != null) 'text-transform': '$textTransform',
      if (userSelect != null) 'user-select': '$userSelect',
      if (overflowX != null) 'overflow-x': '$overflowX',
      if (overflowY != null) 'overflow-y': '$overflowY',
      if (opacity != null) 'opacity': '$opacity',
      if (transform != null) 'transform': '$transform',
      if (transition != null) 'transition': '$transition',
      if (accentColor != null) 'accent-color': '$accentColor',
    };
  }
}

class _Raw with Style {
  final Map<String, String> rules;

  const _Raw(this.rules);

  @override
  Map<String, String> toMap() => rules;
}
