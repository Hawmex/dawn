class Color {
  final int red;
  final int green;
  final int blue;
  final int alpha;

  const Color({
    required this.red,
    required this.green,
    required this.blue,
    this.alpha = 255,
  });

  String get rgbaString => 'rgba($red, $green, $blue, ${alpha / 255})';

  String get hexString => '#'
      '${toValidHex(red)}'
      '${toValidHex(green)}'
      '${toValidHex(blue)}'
      '${toValidHex(alpha)}';

  String toValidHex(final int value) {
    final initialHex = value.toRadixString(16);
    return initialHex.length < 2 ? '0$initialHex' : initialHex;
  }

  Color copyWith({
    final int? red,
    final int? green,
    final int? blue,
    final int? alpha,
  }) =>
      Color(
        red: red ?? this.red,
        green: green ?? this.green,
        blue: blue ?? this.blue,
        alpha: alpha ?? this.alpha,
      );
}
