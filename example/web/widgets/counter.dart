import 'package:dawn/dawn.dart';

import 'theme.dart';

final _counterState = CounterState();

void incrementCounter() => _counterState.increment();

class Counter extends StatefulWidget {
  const Counter() : super();

  @override
  State<StatefulWidget> createState() => _counterState;
}

class CounterState extends State<Counter> {
  int count = 0;

  void increment() => setState(() => count += 1);

  @override
  Widget build(final Context context) {
    final theme = Theme.of(context);

    return Container(
      [
        Image(
          'https://picsum.photos/id/${count ~/ 5}/800/450',
          styles: const Styles(['border-radius: 16px', 'max-width: 100%']),
        ),
        Container(
          [
            Text('تعداد ضربات: $count'),
            if (count > 0 && count % 5 == 0) const Text('هوپ!'),
          ],
          styles: const Styles([
            'display: flex',
            'flex-flow: column',
            'align-items: center',
          ]),
        )
      ],
      styles: Styles([
        'display: flex',
        'flex-flow: column',
        'align-items: center',
        'gap: 16px',
        'padding: 16px',
        'overflow-y: auto',
        'background-color: ${theme.surface.hexString}',
        'color: ${theme.onSurface.hexString}'
      ]),
    );
  }
}
