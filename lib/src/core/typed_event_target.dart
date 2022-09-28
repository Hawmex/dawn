import 'dart:html' as html;

import 'package:js/js.dart';

typedef EventListener<T extends html.Event> = void Function(T event);

@JS('__dawnAddEventListener__')
external final void Function(
  dynamic target,
  dynamic type,
  dynamic listener,
  dynamic useCapture,
) _addEventListener;

@JS('__dawnRemoveEventListener__')
external final void Function(
  dynamic target,
  dynamic type,
  dynamic listener,
  dynamic useCapture,
) _removeEventListener;

extension TypedEventTarget on html.EventTarget {
  void addTypedEventListener<T extends html.Event>(
    final String type,
    final EventListener<T>? listener, {
    final bool? useCapture,
  }) {
    if (listener != null) {
      _addEventListener(this, type, listener, useCapture);
    }
  }

  void removeTypedEventListener<T extends html.Event>(
    final String type,
    final EventListener<T>? listener, {
    final bool? useCapture,
  }) {
    if (listener != null) {
      _removeEventListener(this, type, listener, useCapture);
    }
  }
}
