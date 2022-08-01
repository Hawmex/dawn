import 'package:dawn/foundation.dart';

abstract class Widget {
  final String? key;

  const Widget({this.key});

  bool matches(final Widget otherWidget) =>
      runtimeType == otherWidget.runtimeType && key == otherWidget.key;

  Node createNode();
}
