part of dawn;

class UserInputController {
  String _value;

  late html.Element _element;

  UserInputController([final String? value]) : _value = value ?? '';

  String get value => _value;

  set value(final String newValue) {
    _value = newValue;
    (_element as dynamic).value = newValue;
  }
}
