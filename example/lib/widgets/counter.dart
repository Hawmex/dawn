import 'dart:async';

import 'package:dawn/dawn.dart';

class Counter extends StatefulWidget {
  const Counter() : super();

  @override
  State<StatefulWidget> createState() => _CounterState();
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
  Widget build(final Context context) => Text(count.toString());
}
