import 'dart:async';

import 'package:dawn/dawn.dart';

void main() => runApp(const App());

class App extends StatelessComponent {
  const App() : super();

  @override
  List<Component> render(final Context context) => const [HomePage()];
}

class HomePage extends StatefulComponent {
  const HomePage() : super();

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
    print(_count);

    if (_count % 5 != 0) {
      return const [Container()];
    } else {
      return [];
    }
  }
}

class Container extends StatefulComponent {
  const Container() : super();

  @override
  State<StatefulComponent> createState() => _ContainerState();
}

class _ContainerState extends State<Container> {
  @override
  void initialize() {
    super.initialize();
    print('initialized container');
  }

  @override
  void dispose() {
    super.dispose();
    print('disposed container');
  }

  @override
  List<Component> render(final Context context) => [];
}
