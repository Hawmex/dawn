import 'dart:async';

import 'package:dawn/dawn.dart';

void main() => runApp(const App());

class App extends StatelessComponent {
  const App() : super();

  @override
  List<Component> render(final Context context) => [HomePage()];
}

class HomePage extends StatefulComponent {
  late Timer _timer;
  int count = 0;

  void increment() => setState(() => count += 1);

  @override
  void initialize() {
    super.initialize();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
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
    print(count);

    if (count % 2 == 0) {
      return const [Container()];
    } else {
      return [];
    }
  }
}

class Container extends StatelessComponent {
  const Container() : super();

  @override
  List<Component> render(final Context context) {
    print('rendered container!');
    return [];
  }
}
