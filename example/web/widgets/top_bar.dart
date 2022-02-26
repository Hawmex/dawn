import 'dart:html';

import 'package:dawn/dawn.dart';

import 'icon_button.dart';
import 'theme.dart';

class TopBar extends StatelessWidget {
  final Widget leading;
  final String title;
  final List<Widget>? trailing;

  TopBar({
    final Widget? leading,
    required this.title,
    this.trailing,
  })  : leading = leading ??
            IconButton(
              'arrow_forward',
              onPress: (final event) => window.history.back(),
            ),
        super();

  @override
  Widget build(final Context context) {
    final theme = Theme.of(context);

    return Container(
      [
        Container(
          [
            leading,
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
      styles: Styles([
        'display: flex',
        'flex-flow: row',
        'padding: 8px',
        'gap: 8px',
        'background: ${theme.surface.hexString}',
        'color: ${theme.primary.hexString}',
        'border-bottom: 1px solid ${theme.onSurface.copyWith(alpha: 20).hexString}',
        'justify-content: space-between',
      ]),
    );
  }
}
