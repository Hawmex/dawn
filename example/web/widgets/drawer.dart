import 'package:dawn/dawn.dart';

final _drawerState = DrawerState();

void openDrawer() => _drawerState.open();

class Drawer extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<Widget> content;

  const Drawer({
    required this.title,
    required this.subtitle,
    required this.content,
  }) : super();

  @override
  State<StatefulWidget> createState() => _drawerState;
}

class DrawerState extends State<Drawer> {
  bool isOpen = false;

  void open() => setState(() => isOpen = true);
  void close() => setState(() => isOpen = false);

  @override
  Widget build(final Context context) {
    return Container(
      [
        Container(
          [],
          styles: Styles([
            'position: absolute',
            'pointer-events: all',
            'width: 100%',
            'height: 100%',
            'left: 0px',
            'top: 0px',
            'background-color: #000000',
            'opacity: 0',
            'visibility: hidden',
            'transition: all 200ms',
            if (isOpen) ...[
              'opacity: 0.16',
              'visibility: visible',
              'transition: all 250ms',
            ]
          ]),
          onPointerDown: (final event) => close(),
        ),
        Container(
          [
            Container(
              [
                Text(
                  widget.title,
                  styles: const Styles(['font-weight: 700', 'font-size: 20px']),
                ),
                Text(widget.subtitle)
              ],
              styles: const Styles([
                'display: flex',
                'flex-flow: column',
                'padding: 8px 16px',
              ]),
            ),
            Container(
              widget.content,
              styles: const Styles([
                'display: flex',
                'flex-flow: column',
                'gap: 8px',
                'padding: 8px',
              ]),
            ),
          ],
          styles: Styles([
            'position: absolute',
            'right: 0px',
            'top: 0px',
            'height: 100%',
            'width: 256px',
            'display: flex',
            'flex-flow: column',
            'background-color: #ffffff',
            'gap: 16px',
            'transform: translateX(100%)',
            'transition: transform 200ms',
            if (isOpen) ...[
              'transform: translateX(0%)',
              'transition: transform 250ms',
            ]
          ]),
        ),
      ],
      styles: const Styles([
        'position: fixed',
        'top: 0px',
        'left: 0px',
        'width: 100vw',
        'height: 100vh',
        'pointer-events: none',
      ]),
    );
  }
}
