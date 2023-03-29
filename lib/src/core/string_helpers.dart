/// Adds some utilities to transform strings.
extension StringHelpers on String {
  /// Capitalizes the first letter of this string and returns a new one.
  String toCapitalized() =>
      substring(0, 1).toUpperCase() + substring(1).toLowerCase();

  /// Replaces all the unnecessary whitespace in this string with a single space
  /// and returns a new one.
  String trimAll() => trim().replaceAll(RegExp(r'\s+'), ' ');

  /// Transforms a kebab-case string to a camelCase one and returns it.
  String fromKebabCaseToCamelCase() {
    final parts = split('-')..removeWhere((final part) => part.isEmpty);
    final words = parts.map((final part) => part.toCapitalized()).toList();

    words.first = words.first.toLowerCase();

    return words.join();
  }
}
