import 'package:dawn/dawn.dart';

class Icon extends StatelessWidget {
  final String value;
  final Styles? styles;

  const Icon(this.value, {this.styles}) : super();

  @override
  Widget build(final Context context) {
    return Text(
      value,
      styles: Styles([
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
        'pointer-events: none',
        '-webkit-font-feature-settings: liga',
        '-webkit-font-smoothing: antialiased',
        if (styles != null) ...styles!.rules
      ]),
    );
  }
}
