import 'dart:async';

import 'package:dawn/dawn.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App() : super();

  @override
  List<Widget> build(final Context context) => const [HomePage()];
}

class HomePage extends StatefulWidget {
  const HomePage() : super();

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;

  void increment() => setState(() => count += 1);

  @override
  void initialize() {
    super.initialize();
    Timer.periodic(const Duration(seconds: 1), (final timer) => increment());
  }

  @override
  List<Widget> build(final Context context) {
    print(count);
    return const [Column([])];
  }
}
