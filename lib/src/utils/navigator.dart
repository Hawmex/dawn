import 'dart:html' as html;

class Navigator {
  static final Map<String, String> parameters = {};

  static String get path => html.window.location.hash.length < 2
      ? '/'
      : html.window.location.hash.substring(1);

  static void pop() => html.window.history.back();
  static void push(final String path) => html.window.location.hash = '#$path';
}
