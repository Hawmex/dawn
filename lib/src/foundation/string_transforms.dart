extension StringTransforms on String {
  String toCapitalized() =>
      substring(0, 1).toUpperCase() + substring(1).toLowerCase();

  String trimAll() => trim().replaceAll(RegExp(r'\s+'), ' ');

  String fromKebabCaseToCamelCase() {
    final parts = split('-')..removeWhere((final part) => part.isEmpty);
    final words = parts.map((final part) => part.toCapitalized()).toList();

    words.first = words.first.toLowerCase();

    return words.join();
  }
}
