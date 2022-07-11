extension StringTransforms on String {
  /// Capitalizes the first letter and lowercases the rest of them.
  String toCapitalized() =>
      isEmpty ? '' : this[0].toUpperCase() + substring(1).toLowerCase();

  /// Removes all the unnecessary whitespace from a string.
  String trimAll() => replaceAll(RegExp(r'\s+'), ' ');

  /// Transforms a string from kebab-case to camelCase.
  String fromKebabCaseToCamelCase() {
    final parts = split('-');

    final words = parts
      ..removeWhere((final part) => part.isEmpty)
      ..map((final part) => part.toCapitalized()).toList();

    words.first = words.first.toLowerCase();

    return words.join();
  }
}
