// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_resolution_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FirebaseResolutionModelImpl _$$FirebaseResolutionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FirebaseResolutionModelImpl(
      resolutionName: json['resolutionName'] as String?,
      goalStatement: json['goalStatement'] as String?,
      actionStatement: json['actionStatement'] as String?,
      isActive: json['isActive'] as bool?,
      colorIndex: json['colorIndex'] as int?,
      actionPerWeek: json['actionPerWeek'] as int?,
      startDate: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['startDate'], const TimestampConverter().fromJson),
      shareFriendIdList: (json['shareFriendIdList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      shareGroupIdList: (json['shareGroupIdList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$FirebaseResolutionModelImplToJson(
        _$FirebaseResolutionModelImpl instance) =>
    <String, dynamic>{
      'resolutionName': instance.resolutionName,
      'goalStatement': instance.goalStatement,
      'actionStatement': instance.actionStatement,
      'isActive': instance.isActive,
      'colorIndex': instance.colorIndex,
      'actionPerWeek': instance.actionPerWeek,
      'startDate': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.startDate, const TimestampConverter().toJson),
      'shareFriendIdList': instance.shareFriendIdList,
      'shareGroupIdList': instance.shareGroupIdList,
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
