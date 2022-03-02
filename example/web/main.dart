import 'package:dawn/dawn.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App() : super();

  @override
  Widget build(final Context context) {
    return const Container(
      [
        Text(
          'Dawn App Running!',
          styles: Styles(['font-size: 24px', 'font-weight: 700']),
        )
      ],
      styles: Styles([
        'display: flex',
        'width: 100vw',
        'height: 100vh',
        'justify-content: center',
        'align-items: center',
      ]),
    );
  }
}
