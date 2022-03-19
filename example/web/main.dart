import 'package:dawn/dawn.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({final String? key}) : super(key: key);

  @override
  Widget build(final Context context) {
    return const Container(
      [
        Image(
          '/assets/logo.svg',
          style: Style({'width': '128px', 'height': '128px'}),
          animation: Animation(
            keyframes: [
              {'transform': 'scale(0.8)'},
              {'transform': 'scale(1.0)'}
            ],
            options: {
              'duration': 1000,
              'iterations': double.infinity,
              'direction': 'alternate',
              'easing': 'cubic-bezier(0.2, 0.0, 0.4, 1)',
            },
          ),
        ),
        Text(
          'Welcome to Dawn',
          style: Style({'font-size': '24px', 'font-weight': 'bold'}),
        ),
        Container([
          Text('To get started, edit '),
          Text(
            'web/main.dart',
            style: Style({
              'font-family': 'monospace',
              'background': '#666666',
              'border-radius': '4px',
              'padding': '4px',
            }),
          ),
          Text(' and save to reload.'),
        ]),
      ],
      style: Style({
        'display': 'flex',
        'flex-flow': 'column',
        'justify-content': 'center',
        'align-items': 'center',
        'gap': '16px',
        'width': '100%',
        'height': '100vh',
        'background': '#000000',
        'color': '#ffffff',
        'font-family': 'system-ui',
        'user-select': 'none',
      }),
    );
  }
}
