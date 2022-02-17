import 'package:dawn/dawn.dart';

import 'icon.dart';

class IconButton extends StatefulWidget {
  final String icon;

  const IconButton(this.icon) : super();

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
      styles: Styles([
        'display: flex',
        'padding: 8px',
        'border-radius: 50%',
        'cursor: pointer',
        'transition: all 200ms',
        if (isShowingHoverStyles) ...[
          'background-color: rgba(255, 255, 255, 0.08)',
          'transition: all 250ms'
        ],
      ]),
      onPointerEnter: [(final event) => showHoverStyles()],
      onPointerLeave: [(final event) => hideHoverStyles()],
    );
  }
}
