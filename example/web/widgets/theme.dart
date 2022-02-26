import 'package:dawn/dawn.dart';

import '../models/color.dart';

class Theme extends StatelessWidget {
  final Widget child;

  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color error;

  final Color onPrimary;
  final Color onSecondary;
  final Color onTertiary;
  final Color onError;

  final Color primaryContainer;
  final Color secondaryContainer;
  final Color tertiaryContainer;
  final Color errorContainer;

  final Color onPrimaryContainer;
  final Color onSecondaryContainer;
  final Color onTertiaryContainer;
  final Color onErrorContainer;

  final Color background;
  final Color surface;
  final Color surfaceVariant;

  final Color onBackground;
  final Color onSurface;
  final Color onSurfaceVariant;

  final Color outline;

  const Theme(
    this.child, {
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.error,
    required this.onPrimary,
    required this.onSecondary,
    required this.onTertiary,
    required this.onError,
    required this.primaryContainer,
    required this.secondaryContainer,
    required this.tertiaryContainer,
    required this.errorContainer,
    required this.onPrimaryContainer,
    required this.onSecondaryContainer,
    required this.onTertiaryContainer,
    required this.onErrorContainer,
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.onBackground,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.outline,
  }) : super();

  factory Theme.of(final Context context) =>
      context.getParentWidgetOfExactType<Theme>();

  @override
  Widget build(final Context context) => child;
}
