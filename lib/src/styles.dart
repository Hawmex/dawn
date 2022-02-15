class Styles {
  final List<String> _rules;

  const Styles(this._rules);

  String get rules {
    if (_rules.isEmpty) {
      return '';
    } else {
      return _rules.reduce((final sum, final rule) => '$sum; $rule');
    }
  }
}
