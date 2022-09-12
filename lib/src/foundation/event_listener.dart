import 'dart:html' as html;

/// A helper for defining type-specific event listeners.
typedef EventListener<T extends html.Event> = void Function(T event);
