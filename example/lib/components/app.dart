import 'package:dawn/dawn.dart';

import 'icon_button.dart';
import 'top_bar.dart';

class App extends StatelessComponent {
  const App() : super();

  @override
  List<Component> render(final Context context) {
    return [
      Container(
        [
          TopBar(
            leadingIcon: 'menu',
            title: 'اپ داون',
            trailingBuilder: (final context) => const [IconButton('search')],
          ),
        ],
        styles: const Styles([
          'user-select: none',
          'font-family: Dana',
          'direction: rtl',
        ]),
      )
    ];
  }
}
