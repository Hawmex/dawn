part of dawn;

abstract class State<T extends StatefulWidget> extends Store with Buildable {
  late final Context context;

  late T _widget;

  bool _isMounted = false;

  T get widget => _widget;
  bool get isMounted => _isMounted;

  void initialize() {}
  void didMount() => _isMounted = true;
  void willUnmount() {}
  void dispose() => _isMounted = false;
}
