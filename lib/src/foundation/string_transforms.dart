extension StringTransforms on String {
  String toCapitalized() =>
      isEmpty ? '' : this[0].toUpperCase() + substring(1).toLowerCase();

  String trimAll() => replaceAll(RegExp(r'\s+'), ' ');

  String fromKebabCaseToCamelCase() {
    final parts = split('-');

    final words = parts
      ..removeWhere((final part) => part.isEmpty)
      ..map((final part) => part.toCapitalized()).toList();

    words.first = words.first.toLowerCase();

    return words.join();
  }
}
