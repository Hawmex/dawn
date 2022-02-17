import 'dart:async';

import 'package:dawn/dawn.dart';

import 'counter.dart';
import 'icon_button.dart';
import 'top_bar.dart';

class App extends StatefulWidget {
  const App() : super();

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  late final Timer timer;

  int count = 0;

  @override
  void initialize() {
    super.initialize();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (final timer) => setState(() => count += 1),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(final Context context) {
    return Container(
      [
        TopBar(
          leadingIcon: 'menu',
          title: 'اپ داون',
          trailingBuilder: (final context) => const [IconButton('search')],
        ),
        Container(
          [
            const Text('ثانیه گذشته:'),
            const Counter(),
            if (count % 5 == 0) const Text('مضرب پنج!'),
          ],
          styles: const Styles([
            'margin: auto',
            'display: flex',
            'flex-flow: column',
            'align-items: center'
          ]),
        ),
      ],
      styles: const Styles([
        'user-select: none',
        'font-family: Dana',
        'direction: rtl',
        'height: 100vh',
        'display: flex',
        'flex-flow: column',
      ]),
    );
  }
}
