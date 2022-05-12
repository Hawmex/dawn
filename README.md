# dawn

## Description

Dawn is a Dart web package for developing UIs in a pattern similar to Flutter.

## Links

- [GitHub Repository](https://github.com/Hawmex/dawn)
- [Pub Page](https://pub.dev/packages/dawn)
- [Documentation](https://pub.dev/documentation/dawn/latest/dawn/dawn-library.html)
- An Example Weather SPA created with Dawn
  - [Live Demo](https://dawnweather.netlify.app)
  - [GitHub Repository](https://github.com/Hawmex/dawn_weather_app)

## Example

```dart
import 'package:dawn/dawn.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({final super.key});

  @override
  Widget build(final Context context) {
    return const Text(
      'Hello World!',
      style: Style({'font-weight': 'bold'}),
    );
  }
}
```
