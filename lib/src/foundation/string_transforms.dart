extension StringTransforms on String {
  /// Capitalizes the first letter of this [String].
  String toCapitalized() =>
      substring(0, 1).toUpperCase() + substring(1).toLowerCase();

  /// Replaces all whitespace characters in this [String] with a space.
  String trimAll() => trim().replaceAll(RegExp(r'\s+'), ' ');

  /// Transforms this [String] from kebab-case to camelCase.
  String fromKebabCaseToCamelCase() {
    final parts = split('-')..removeWhere((final part) => part.isEmpty);
    final words = parts.map((final part) => part.toCapitalized()).toList();

    words.first = words.first.toLowerCase();

    return words.join();
  }
}
