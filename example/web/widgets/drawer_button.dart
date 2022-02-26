import 'package:dawn/dawn.dart';

import 'icon.dart';
import 'theme.dart';

class DrawerButton extends StatefulWidget {
  final String icon;
  final String text;
  final EventListener? onPress;

  const DrawerButton({required this.icon, required this.text, this.onPress})
      : super();

  @override
  State<StatefulWidget> createState() => DrawerButtonState();
}

class DrawerButtonState extends State<DrawerButton> {
  bool isShowingHoverStyles = false;

  void showHoverStyles() => setState(() => isShowingHoverStyles = true);
  void hideHoverStyles() => setState(() => isShowingHoverStyles = false);

  @override
  Widget build(final Context context) {
    final theme = Theme.of(context);

    return Container(
      [
        Icon(widget.icon),
        Text(widget.text, styles: const Styles(['font-weight: 500']))
      ],
      onPress: widget.onPress,
      onPointerEnter: (final event) => showHoverStyles(),
      onPointerLeave: (final event) => hideHoverStyles(),
      styles: Styles([
        'display: flex',
        'padding: 8px',
        'gap: 24px',
        'border-radius: 8px',
        'cursor: pointer',
        'color: ${theme.onSurface.hexString}',
        'transition: background-color 200ms',
        if (isShowingHoverStyles) ...[
          'background-color: ${theme.onSurface.copyWith(alpha: 20).hexString}',
          'transition: background-color 250ms',
        ],
      ]),
    );
  }
}
