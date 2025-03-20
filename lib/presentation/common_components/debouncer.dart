import 'dart:async';

class Debouncer {
  Debouncer({required this.delay});

  final Duration delay;
  Timer? _timer;

  void run(void Function() action) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(delay, action);
  }
}
