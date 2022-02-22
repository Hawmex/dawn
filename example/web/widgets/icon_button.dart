import 'package:dawn/dawn.dart';

import 'icon.dart';

class IconButton extends StatefulWidget {
  final String icon;
  final EventListener? onPress;

  const IconButton(this.icon, {this.onPress}) : super();

  @override
  State<StatefulWidget> createState() => _IconButtonState();
}

class _IconButtonState extends State<IconButton> {
  bool isShowingHoverStyles = false;

  void showHoverStyles() => setState(() => isShowingHoverStyles = true);
  void hideHoverStyles() => setState(() => isShowingHoverStyles = false);

  @override
  Widget build(final Context context) {
    return Container(
      [Icon(widget.icon)],
      onPress: widget.onPress,
      onPointerEnter: (final event) => showHoverStyles(),
      onPointerLeave: (final event) => hideHoverStyles(),
      styles: Styles([
        'display: flex',
        'padding: 8px',
        'border-radius: 50%',
        'cursor: pointer',
        'transition: all 200ms',
        '-webkit-tap-highlight-color: transparent',
        if (isShowingHoverStyles) ...[
          'background-color: rgba(255, 255, 255, 0.08)',
          'transition: all 250ms'
        ],
      ]),
    );
  }
}
