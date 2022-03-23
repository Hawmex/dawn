part of dawn;

abstract class Controller<T extends html.Element> {
  late T _element;

  void _initializeElement() {}
  void _disposeElement() {}
}

class UserInputController extends Controller<html.Element> {
  final String _initialValue;

  UserInputController([final String? initialValue])
      : _initialValue = initialValue ?? '';

  String get value => (_element as dynamic).value;

  set value(final String newValue) => (_element as dynamic).value = newValue;

  @override
  void _initializeElement() {
    super._initializeElement();
    (_element as dynamic).value = _initialValue;
  }
}
