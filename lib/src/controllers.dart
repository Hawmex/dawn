part of dawn;

class Controller<T extends html.Element> {
  late T _element;

  void _initializeElement() {}
  void _disposeElement() {}
}

class UserInputController extends Controller<html.Element> {
  String _value;

  UserInputController([final String? value]) : _value = value ?? '';

  String get value => _value;

  set value(final String newValue) {
    _value = newValue;
    (_element as dynamic).value = newValue;
  }

  @override
  void _initializeElement() {
    super._initializeElement();
    (_element as dynamic).value = value;
  }
}
