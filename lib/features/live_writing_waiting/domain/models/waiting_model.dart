import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/features/live_writing_waiting/domain/models/counter_state.dart';

part 'waiting_model.g.dart';

const int fixedTimeHour = 22; // 실시간 인증 시간, 고정: 22시
const int availableWaitingTimeMinute = 3; // 글 쓰기 전 기다리는 시간: 3min
const int availableWritingLimitMinute = 10; // 실시간 글 작성 제한 시간: 10min

@riverpod
class Waiting extends _$Waiting {
  final DateTime _targetTime = DateTime(DateTime.now().year, DateTime.now().month,
    DateTime.now().day, fixedTimeHour,);

  @override
  CounterState build() {
    // 실시간 인증 전까지 3분 이내에는 대기
    // 0 < _timeLeft.inSeconds <= 60*3
    if (0 < _timeLeft.inSeconds && _timeLeft.inSeconds <= availableWaitingTimeMinute*60) {
      return const CounterState(
        counterStateEnum: CounterStateEnum.isTimeForWaiting,
      );
    }

    // 실시간 인증 후 10분 이내에는 글 작성
    // -60*10 <= _timeLeft.inSeconds <= 0
    if (-availableWritingLimitMinute*60 <= _timeLeft.inSeconds && _timeLeft.inSeconds <= 0) {
      return const CounterState(
        counterStateEnum: CounterStateEnum.isTimeForWriting,
      );
    }

    return const CounterState(
      counterStateEnum: CounterStateEnum.isTimeOver,
    );
  }

  Stream<String> getTimerStream() async* {
    if (build().counterStateEnum == CounterStateEnum.isTimeForWaiting) {
      while (true) {
        if (_timeLeft.inSeconds <= 0) {
          setCounterState(CounterStateEnum.isTimeForWriting);
          break;
        }
        yield getTimerString();
        await Future.delayed(const Duration(seconds: 1));
      }
    }
    if (build().counterStateEnum == CounterStateEnum.isTimeForWriting) {
      yield '준비하세요!';
    } else {
      yield '종료되었습니다.';
    }
  }

  Duration get _timeLeft => _targetTime.difference(DateTime.now());

  String getTimerString() {
    final Duration timeLeft = _timeLeft;
    final int hour = timeLeft.inHours;
    final int minute = timeLeft.inMinutes.remainder(60);
    final int second = timeLeft.inSeconds.remainder(60);

    if (_timeLeft.inHours == 0) {
      return '${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';
    }
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';
  }

  void setCounterState(CounterStateEnum counterStateEnum) {
    state = state.copyWith(counterStateEnum: counterStateEnum);
  }
}