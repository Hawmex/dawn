part of dawn;

abstract class State<T extends StatefulWidget> extends Store with Buildable {
  late final T widget;
  late final Context context;

  bool _isMounted = false;

  bool get isMounted => _isMounted;

  void initialize() {}
  void didMount() => _isMounted = true;
  void willUnmount() {}
  void dispose() => _isMounted = false;
}
