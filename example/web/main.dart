import 'package:dawn/dawn.dart';

import 'models/color.dart';
import 'widgets/home_screen.dart';
import 'widgets/theme.dart';

void main() {
  runApp(
    const Theme(
      App(),
      primary: Color(red: 103, green: 80, blue: 164),
      secondary: Color(red: 98, green: 91, blue: 113),
      tertiary: Color(red: 125, green: 82, blue: 96),
      error: Color(red: 179, green: 38, blue: 30),
      onPrimary: Color(red: 255, green: 255, blue: 255),
      onSecondary: Color(red: 255, green: 255, blue: 255),
      onTertiary: Color(red: 255, green: 255, blue: 255),
      onError: Color(red: 255, green: 255, blue: 255),
      primaryContainer: Color(red: 234, green: 221, blue: 255),
      secondaryContainer: Color(red: 232, green: 222, blue: 248),
      tertiaryContainer: Color(red: 255, green: 216, blue: 228),
      errorContainer: Color(red: 249, green: 222, blue: 220),
      onPrimaryContainer: Color(red: 33, green: 0, blue: 94),
      onSecondaryContainer: Color(red: 30, green: 25, blue: 43),
      onTertiaryContainer: Color(red: 55, green: 11, blue: 30),
      onErrorContainer: Color(red: 55, green: 11, blue: 30),
      background: Color(red: 255, green: 251, blue: 254),
      surface: Color(red: 255, green: 251, blue: 254),
      surfaceVariant: Color(red: 231, green: 224, blue: 236),
      onBackground: Color(red: 28, green: 27, blue: 31),
      onSurface: Color(red: 28, green: 27, blue: 31),
      onSurfaceVariant: Color(red: 73, green: 69, blue: 78),
      outline: Color(red: 121, green: 116, blue: 126),
    ),
  );
}

class App extends StatelessWidget {
  const App() : super();

  @override
  Widget build(final Context context) => const HomeScreen();
}
