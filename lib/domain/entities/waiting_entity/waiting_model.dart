import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/domain/entities/counter_state/counter_state.dart';

part 'waiting_model.g.dart';

const int fixedTimeHour = 22; // 실시간 인증 시간, 고정: 22시
const int fixedTimeMinute = 0; // 실시간 인증 시간, 고정: 00분
const int availableWaitingTimeMinute = 3; // 글 쓰기 전 기다리는 시간: 3min
const int availableWritingLimitMinute = 5; // 실시간 글 작성 제한 시간: 5min

@riverpod
class Waiting extends _$Waiting {
  // TODO. This is for debug. If needed, uncomment this and set time to test
  static int fixedTimeHour = DateTime.now().hour;
  static int fixedTimeMinute = DateTime.now().minute + 1;
  static int availableWritingLimitMinute = 0;
  static int availableWritingLimitSecond = 30;

  final DateTime _writingStartTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    fixedTimeHour,
    fixedTimeMinute,
  );

  final DateTime _writingEndTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    fixedTimeHour,
    fixedTimeMinute + availableWritingLimitMinute,
    availableWritingLimitSecond,
  );

  @override
  CounterState build() {
    // 실시간 인증 전까지 availableWaitingTimeMinute분 이내에는 대기
    // 0 < _timeLeft.inSeconds <= 60*3
    if (0 < _waitingTimeLeft.inSeconds &&
        _waitingTimeLeft.inSeconds <= availableWaitingTimeMinute * 60) {
      return const CounterState(
        counterStateEnum: CounterStateEnum.timeForWaiting,
      );
    }

    // 실시간 인증 후 availableWritingLimitMinute분 이내에는 글 작성
    // -60*10 <= _timeLeft.inSeconds <= 0
    if (-availableWritingLimitMinute * 60 <= _waitingTimeLeft.inSeconds &&
        _waitingTimeLeft.inSeconds <= 0) {
      return const CounterState(
        counterStateEnum: CounterStateEnum.timeForWriting,
      );
    }

    return const CounterState(
      counterStateEnum: CounterStateEnum.timeOver,
    );
  }

  Stream<String> getWaitingTimerStream() async* {
    if (build().counterStateEnum == CounterStateEnum.timeForWaiting) {
      while (true) {
        if (_waitingTimeLeft.inSeconds <= 0) {
          setCounterState(CounterStateEnum.timeForWriting);
          break;
        }
        yield getTimerString(_waitingTimeLeft);
        await Future.delayed(const Duration(seconds: 1));
      }
    }
    if (build().counterStateEnum == CounterStateEnum.timeForWriting) {
      yield '준비하세요!';
    } else {
      yield '종료되었습니다.';
    }
  }

  Stream<String> getWritingTimerStream() async* {
    if (build().counterStateEnum == CounterStateEnum.timeForWriting) {
      while (true) {
        if (_writingTimeLeft.inSeconds <= 0) {
          setCounterState(CounterStateEnum.timeOver);
          break;
        }
        yield getTimerString(_writingTimeLeft);
        await Future.delayed(const Duration(seconds: 1));
      }
    }
    if (build().counterStateEnum == CounterStateEnum.timeForWaiting) {
      yield '아직 대기 중입니다.';
    } else {
      yield '종료되었습니다.';
    }
  }

  Duration get _waitingTimeLeft => _writingStartTime.difference(DateTime.now());

  Duration get _writingTimeLeft => _writingEndTime.difference(DateTime.now());

  String getTimerString(Duration timeLeft) {
    // final Duration timeLeft = _waitingTimeLeft;
    final int hour = timeLeft.inHours;
    final int minute = timeLeft.inMinutes.remainder(60);
    final int second = timeLeft.inSeconds.remainder(60);

    if (_waitingTimeLeft.inHours == 0) {
      return '${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';
    }
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';
  }

  void setCounterState(CounterStateEnum counterStateEnum) {
    state = state.copyWith(counterStateEnum: counterStateEnum);
  }
}
