import 'dart:async';

import 'package:dawn/dawn.dart';

class Counter extends StatefulComponent {
  const Counter() : super();

  @override
  State<StatefulComponent> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  late final Timer timer;

  int count = 0;

  @override
  void initialize() {
    super.initialize();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (final timer) => setState(() => count += 1),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  List<Component> render(final Context context) => [Text(count.toString())];
}
