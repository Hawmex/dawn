import 'package:dawn/dawn.dart';

class Icon extends StatelessWidget {
  final String value;

  const Icon(this.value) : super();

  @override
  Widget build(final Context context) {
    return Text(
      value,
      styles: const Styles([
        'font-family: Material Icons',
        'font-weight: normal',
        'font-style: normal',
        'font-size: 24px',
        'line-height: 1',
        'letter-spacing: normal',
        'text-transform: none',
        'display: inline-block',
        'white-space: nowrap',
        'word-wrap: normal',
        'direction: ltr',
        '-webkit-font-feature-settings: liga',
        '-webkit-font-smoothing: antialiased',
      ]),
    );
  }
}
