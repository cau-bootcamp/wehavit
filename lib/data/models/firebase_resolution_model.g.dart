// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_resolution_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FirebaseResolutionModelImpl _$$FirebaseResolutionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FirebaseResolutionModelImpl(
      goalStatement: json['goalStatement'] as String?,
      actionStatement: json['actionStatement'] as String?,
      isActive: json['isActive'] as bool?,
      actionPerWeek: json['actionPerWeek'] as int?,
      startDate: const TimestampSerializer().fromJson(json['startDate']),
      fanUserIdList: (json['fanUserIdList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      documentId: json['documentId'] as String?,
    );

Map<String, dynamic> _$$FirebaseResolutionModelImplToJson(
        _$FirebaseResolutionModelImpl instance) =>
    <String, dynamic>{
      'goalStatement': instance.goalStatement,
      'actionStatement': instance.actionStatement,
      'isActive': instance.isActive,
      'actionPerWeek': instance.actionPerWeek,
      'startDate': _$JsonConverterToJson<dynamic, DateTime>(
          instance.startDate, const TimestampSerializer().toJson),
      'fanUserIdList': instance.fanUserIdList,
      'documentId': instance.documentId,
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
