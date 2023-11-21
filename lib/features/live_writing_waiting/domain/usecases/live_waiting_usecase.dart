class LiveWaitingUseCase {
  LiveWaitingUseCase({required DateTime now, required int timeLimit}) {
    _now = now;
    _timeLimit = timeLimit;
  }

  late final DateTime _now;
  late final int _timeLimit; // seconds

  int get timeLimit => _timeLimit;

  int get timeLeft => _timeLimit - _now.second;

  bool get isTimeOver => _now.second >= _timeLimit;

  int get timeOver => _now.second - _timeLimit;
}
