/// The base class for all Dawn widgets.
abstract class Widget {
  /// Keys are used in distinguishing unique widgets in the diffing process. It
  /// also can be used to perform animations on a widget on every rebuild.
  final String? key;

  const Widget({this.key});
}
