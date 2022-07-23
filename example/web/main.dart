import 'package:dawn/dawn.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(final BuildContext context) {
    return Container(
      [
        Image(
          '/assets/logo.svg',
          style: Style(width: 128.px, height: 128.px),
          animation: Animation(
            keyframes: const [
              Style(transform: Transform([Scale.only(x: 0.8, y: 0.8)])),
              Style(transform: Transform([Scale.only(x: 1.0, y: 1.0)])),
            ],
            duration: const Duration(seconds: 1),
            easing: const Easing.cubicBezier(0.2, 0, 0.4, 1),
            direction: AnimationDirection.forwardsThenAlternating,
            iterations: double.infinity,
          ),
        ),
        Text(
          'Welcome to Dawn',
          style: Style(fontSize: 24.px, fontWeight: FontWeight.bold),
        ),
        Container(
          [
            const Text('To get started, edit '),
            Text(
              'web/main.dart',
              style: Style(
                fontFamily: FontFamily.monospace,
                padding: EdgeInsets.all(4.px),
                backgroundColor: const Color.hex(0x232323),
                borderRadius: BorderRadius.all(Radius.circular(4.px)),
              ),
            ),
            const Text(' and save to reload.'),
          ],
        ),
      ],
      style: Style(
        display: Display.flex(
          direction: FlexDirection.column,
          alignItems: ItemsAlignment.center,
          justifyContent: ContentAlignment.center,
          gap: 16.px,
        ),
        width: 100.percent,
        height: 100.vh,
        padding: EdgeInsets.all(16.px),
        fontFamily: const FontFamily('Jost'),
        textColor: Color.white,
        textAlign: TextAlign.center,
        backgroundColor: Color.black,
        userSelect: UserSelect.none,
      ),
    );
  }
}
