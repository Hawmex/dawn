import 'package:dawn/dawn.dart';

import 'icon.dart';

class IconButton extends StatefulWidget {
  final String icon;

  const IconButton(this.icon) : super();

  @override
  State<StatefulWidget> createState() => _IconButtonState();
}

class _IconButtonState extends State<IconButton> {
  String backgroundColorStyle = '';

  void highlightBackground() {
    setState(() {
      backgroundColorStyle = 'background-color: rgba(255, 255, 255, 0.08)';
    });
  }

  void removeBackground() {
    setState(() {
      backgroundColorStyle = '';
    });
  }

  @override
  Widget build(final Context context) {
    return Container(
      [Icon(widget.icon)],
      styles: Styles([
        'display: flex',
        'padding: 8px',
        'border-radius: 50%',
        'cursor: pointer',
        backgroundColorStyle,
      ]),
      onPointerEnter: (final event) => highlightBackground(),
      onPointerLeave: (final event) => removeBackground(),
    );
  }
}
