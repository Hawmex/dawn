part of dawn;

abstract class State<T extends StatefulWidget> extends Store with Buildable {
  late T _widget;
  late Context _context;

  bool _isMounted = false;

  Context get context => _context;
  T get widget => _widget;
  bool get isMounted => _isMounted;

  void initialize() {}
  void didMount() => _isMounted = true;
  void willUnmount() {}
  void dispose() => _isMounted = false;
}
