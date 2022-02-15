import 'package:dawn/dawn.dart';

import 'icon.dart';

class IconButton extends StatelessComponent {
  final String icon;

  const IconButton(this.icon) : super();

  @override
  List<Component> render(final Context context) {
    return [
      Container(
        [Icon(icon)],
        styles: const Styles([
          'padding: 8px',
          'border-radius: 50%',
          'background-color: rgba(255, 255, 255, 0.08)',
        ]),
      )
    ];
  }
}
