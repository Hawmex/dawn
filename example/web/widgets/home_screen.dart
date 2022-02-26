import 'package:dawn/dawn.dart';

import 'counter.dart';
import 'drawer.dart';
import 'drawer_button.dart';
import 'icon_button.dart';
import 'top_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen() : super();

  @override
  Widget build(final Context context) {
    return Container(
      [
        const Drawer(
          title: 'داون',
          subtitle: 'اپ داون',
          content: [DrawerButton(icon: 'info', text: 'درباره ما')],
        ),
        TopBar(
          leading: IconButton('menu', onPress: (final event) => openDrawer()),
          title: 'اپ داون',
          trailing: [
            IconButton('add', onPress: (final event) => incrementCounter())
          ],
        ),
        const Counter(),
      ],
      styles: const Styles([
        'font-family: Dana',
        'direction: rtl',
        'height: 100vh',
        'display: grid',
        'grid-template-rows: max-content 1fr',
        'overflow: hidden',
      ]),
    );
  }
}
