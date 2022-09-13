import 'dart:html' as html;

import 'package:js/js.dart';

/// A helper for defining type-specific event listeners.
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

/// An extension that provides [addListener] and [removeListener].
extension TypedEventListeners on html.EventTarget {
  /// Similar to [addEventListener], but has a type argument.
  void addListener<T extends html.Event>(
    final String type,
    final EventListener<T>? listener, {
    final bool? useCapture,
  }) {
    if (listener != null) {
      _addEventListener(this, type, listener, useCapture);
    }
  }

  /// Similar to [removeEventListener], but has a type argument.
  void removeListener<T extends html.Event>(
    final String type,
    final EventListener<T>? listener, {
    final bool? useCapture,
  }) {
    if (listener != null) {
      _removeEventListener(this, type, listener, useCapture);
    }
  }
}
