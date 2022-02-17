import 'package:dawn/dawn.dart';

import 'icon_button.dart';

class TopBar extends StatelessWidget {
  final String leadingIcon;
  final String title;
  final List<Widget> Function(Context context)? trailingBuilder;

  const TopBar({
    required this.leadingIcon,
    required this.title,
    this.trailingBuilder,
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
          trailingBuilder != null ? trailingBuilder!(context) : [],
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
