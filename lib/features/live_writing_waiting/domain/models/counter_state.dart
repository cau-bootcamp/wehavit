import 'package:freezed_annotation/freezed_annotation.dart';

part 'counter_state.freezed.dart';
part 'counter_state.g.dart';

@freezed
class CounterState with _$CounterState {
  const factory CounterState({
    required CounterStateEnum? counterStateEnum,
  }) = _CounterState;

  factory CounterState.fromJson(Map<String, dynamic> json) =>
      _$CounterStateFromJson(json);
}

enum CounterStateEnum {
  isTimeForWaiting,
  isTimeForWriting,
  isTimeOver,
}
