import 'package:dawn/dawn.dart';

import 'widgets/icon_button.dart';
import 'widgets/top_bar.dart';

void main() => runApp(const App());

class App extends StatefulWidget {
  const App() : super();

  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  int count = 0;

  void increment() => setState(() => count += 1);

  @override
  Widget build(final Context context) {
    return Container(
      [
        TopBar(
          leadingIcon: 'menu',
          title: 'اپ داون',
          trailing: [IconButton('add', onPress: (final event) => increment())],
        ),
        Container(
          [
            Image(
              'https://picsum.photos/id/${count ~/ 5}/800/450',
              styles: const Styles(['border-radius: 16px', 'max-width: 100%']),
            ),
            Container(
              [
                Text('تعداد ضربات: $count'),
                if (count > 0 && count % 5 == 0) ...const [Text('هوپ!')],
              ],
              styles: const Styles([
                'display: flex',
                'flex-flow: column',
                'align-items: center',
              ]),
            )
          ],
          styles: const Styles([
            'margin: auto',
            'display: flex',
            'flex-flow: column',
            'align-items: center',
            'gap: 16px',
            'padding: 16px'
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
