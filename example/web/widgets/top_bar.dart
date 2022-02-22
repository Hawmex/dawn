import 'package:dawn/dawn.dart';

import 'icon_button.dart';

class TopBar extends StatelessWidget {
  final String leadingIcon;
  final String title;
  final List<Widget>? trailing;

  const TopBar({
    required this.leadingIcon,
    required this.title,
    this.trailing,
  }) : super();

  @override
  Widget build(final Context context) {
    return Container(
      [
        Container(
          [
            IconButton(leadingIcon),
            Text(
              title,
              styles: const Styles([
                'padding: 0px 16px',
                'font-size: 20px',
                'font-weight: 700',
              ]),
            ),
          ],
          styles: const Styles([
            'display: flex',
            'flex-flow: row',
            'align-items: center',
          ]),
        ),
        Container(
          trailing ?? [],
          styles: const Styles([
            'display: flex',
            'flex-flow: row',
            'align-items: center',
          ]),
        )
      ],
      styles: const Styles([
        'display: flex',
        'flex-flow: row',
        'padding: 8px',
        'gap: 8px',
        'background: #212121',
        'color: #ffffff',
        'justify-content: space-between',
      ]),
    );
  }
}
