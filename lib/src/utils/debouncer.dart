part of dawn;

class Debouncer {
  Timer? _timer;

  void enqueue(final void Function() task) {
    _timer?.cancel();
    _timer = Timer(Duration.zero, task);
  }
}
