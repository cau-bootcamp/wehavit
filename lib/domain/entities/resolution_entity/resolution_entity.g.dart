// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resolution_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResolutionEntityImpl _$$ResolutionEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$ResolutionEntityImpl(
      resolutionId: json['resolutionId'] as String?,
      resolutionName: json['resolutionName'] as String?,
      goalStatement: json['goalStatement'] as String?,
      actionStatement: json['actionStatement'] as String?,
      isActive: json['isActive'] as bool?,
      actionPerWeek: (json['actionPerWeek'] as num?)?.toInt(),
      colorIndex: (json['colorIndex'] as num?)?.toInt(),
      iconIndex: (json['iconIndex'] as num?)?.toInt(),
      startDate: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['startDate'], const TimestampConverter().fromJson),
      shareFriendEntityList: (json['shareFriendEntityList'] as List<dynamic>?)
          ?.map((e) => UserDataEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      shareGroupEntityList: (json['shareGroupEntityList'] as List<dynamic>?)
          ?.map((e) => GroupEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      writtenPostCount: (json['writtenPostCount'] as num?)?.toInt(),
      receivedReactionCount: (json['receivedReactionCount'] as num?)?.toInt(),
      successWeekMondayList: (json['successWeekMondayList'] as List<dynamic>?)
          ?.map((e) => const TimestampConverter().fromJson(e as Timestamp))
          .toList(),
    );

Map<String, dynamic> _$$ResolutionEntityImplToJson(
        _$ResolutionEntityImpl instance) =>
    <String, dynamic>{
      'resolutionId': instance.resolutionId,
      'resolutionName': instance.resolutionName,
      'goalStatement': instance.goalStatement,
      'actionStatement': instance.actionStatement,
      'isActive': instance.isActive,
      'actionPerWeek': instance.actionPerWeek,
      'colorIndex': instance.colorIndex,
      'iconIndex': instance.iconIndex,
      'startDate': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.startDate, const TimestampConverter().toJson),
      'shareFriendEntityList': instance.shareFriendEntityList,
      'shareGroupEntityList': instance.shareGroupEntityList,
      'writtenPostCount': instance.writtenPostCount,
      'receivedReactionCount': instance.receivedReactionCount,
      'successWeekMondayList': instance.successWeekMondayList
          ?.map(const TimestampConverter().toJson)
          .toList(),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
