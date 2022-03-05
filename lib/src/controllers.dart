part of dawn;

abstract class Controller<T extends Element> {
  late final T _element;

  void _initialize() {}
  void _dispose() {}
}

class UserInputController extends Controller<Element> {
  final _changeController = StreamController<String>.broadcast();
  final _inputController = StreamController<String>.broadcast();

  late final StreamSubscription<Event> _changeSubscription;
  late final StreamSubscription<Event> _inputSubscription;

  String _value = '';

  UserInputController([final String? value]) : _value = value ?? '';

  String get value => _value;

  set value(final String newValue) {
    _value = newValue;
    (_element as dynamic).value = newValue;
  }

  StreamSubscription<String> onChange(
    final void Function(String value) callback,
  ) =>
      _changeController.stream.listen(callback);

  StreamSubscription<String> onInput(
    final void Function(String value) callback,
  ) =>
      _inputController.stream.listen(callback);

  @override
  void _initialize() {
    super._initialize();

    _changeSubscription = _element.onChange.listen((final event) {
      _value = (_element as dynamic).value;
      _changeController.add(value);
    });

    _inputSubscription = _element.onInput.listen((final event) {
      _value = (_element as dynamic).value;
      _inputController.add(value);
    });
  }

  @override
  void _dispose() {
    _inputSubscription.cancel();
    _changeSubscription.cancel();
    super._dispose();
  }
}
