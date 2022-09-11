import 'dart:html' as html;

/// A helper for defining type-specific event listeners.
typedef EventListener<T extends html.Event> = void Function(T event);

final _listenerWrappers = {};

extension TypedEventHandling on html.EventTarget {
  /// Add a listener to the event with the type [T].
  void addTypedEventListener<T extends html.Event>(
    final String name,
    final EventListener<T>? listener,
  ) {
    if (listener != null) {
      dynamic listenerWrapper(final html.Event event) => listener(event as T);
      _listenerWrappers[listener] = listenerWrapper;
      addEventListener(name, listenerWrapper);
    }
  }

  /// Remove a listener to the event with the type [T].
  void removeTypedEventListener<T extends html.Event>(
    final String name,
    final EventListener<T>? listener,
  ) {
    if (listener != null) {
      removeEventListener(name, _listenerWrappers[listener]);
      _listenerWrappers.remove(listener);
    }
  }
}
