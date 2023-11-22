// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CounterStateImpl _$$CounterStateImplFromJson(Map<String, dynamic> json) =>
    _$CounterStateImpl(
      counterStateEnum: $enumDecodeNullable(
          _$CounterStateEnumEnumMap, json['counterStateEnum']),
    );

Map<String, dynamic> _$$CounterStateImplToJson(_$CounterStateImpl instance) =>
    <String, dynamic>{
      'counterStateEnum': _$CounterStateEnumEnumMap[instance.counterStateEnum],
    };

const _$CounterStateEnumEnumMap = {
  CounterStateEnum.isTimeForWaiting: 'isTimeForWaiting',
  CounterStateEnum.isTimeForWriting: 'isTimeForWriting',
  CounterStateEnum.isTimeOver: 'isTimeOver',
};
