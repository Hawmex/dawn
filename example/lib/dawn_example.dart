import 'dart:async';

import 'package:dawn/dawn.dart';

void main() {
  runApp(
    const App(
      styles: 'user-select: none',
    ),
  );
}

class App extends StatelessComponent {
  const App({final String styles = ''}) : super(styles: styles);

  @override
  List<Component> render(final Context context) {
    return const [
      HomePage(
        styles: 'display: grid;'
            'gap: 16px;'
            'background: #212121;'
            'color: #ffffff;'
            'font-family: Jost;'
            'padding: 16px;'
            'border-radius: 16px;',
      )
    ];
  }
}

class HomePage extends StatefulComponent {
  const HomePage({final String styles = ''}) : super(styles: styles);

  @override
  State<StatefulComponent> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer _timer;

  int _count = 0;

  void increment() => setState(() => _count += 1);

  @override
  void initialize() {
    super.initialize();

    _timer = Timer.periodic(
      const Duration(milliseconds: 500),
      (final timer) => increment(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  List<Component> render(final Context context) {
    return [
      Text('Count: $_count'),
      if (_count % 5 != 0) const Text('Hello World!'),
      const Text('By Hawmex.'),
    ];
  }
}
