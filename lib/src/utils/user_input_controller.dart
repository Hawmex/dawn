part of dawn;

typedef UserInputEvent = void Function(String value);

class UserInputController {
  final _changeController = StreamController<String>.broadcast();
  final _inputController = StreamController<String>.broadcast();

  late final StreamSubscription<html.Event> _changeSubscription;
  late final StreamSubscription<html.Event> _inputSubscription;

  String _value = '';

  late html.Element _element;

  UserInputController([final String? value]) : _value = value ?? '';

  String get value => _value;

  set value(final String newValue) {
    _value = newValue;
    (_element as dynamic).value = newValue;
  }

  StreamSubscription<String> onChange(final UserInputEvent callback) =>
      _changeController.stream.listen(callback);

  StreamSubscription<String> onInput(final UserInputEvent callback) =>
      _inputController.stream.listen(callback);

  void _initialize() {
    _changeSubscription = _element.onChange.listen((final event) {
      _value = (_element as dynamic).value;
      _changeController.add(value);
    });

    _inputSubscription = _element.onInput.listen((final event) {
      _value = (_element as dynamic).value;
      _inputController.add(value);
    });
  }

  void _dispose() {
    _inputSubscription.cancel();
    _changeSubscription.cancel();
  }
}
