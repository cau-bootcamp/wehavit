// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resolution_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResolutionEntityImpl _$$ResolutionEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$ResolutionEntityImpl(
      resolutionId: json['resolutionId'] as String?,
      goalStatement: json['goalStatement'] as String?,
      actionStatement: json['actionStatement'] as String?,
      isActive: json['isActive'] as bool?,
      actionPerWeek: json['actionPerWeek'] as int?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      shareFriendEntityList: (json['shareFriendEntityList'] as List<dynamic>?)
          ?.map((e) => UserDataEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      shareGroupEntityList: (json['shareGroupEntityList'] as List<dynamic>?)
          ?.map((e) => GroupEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ResolutionEntityImplToJson(
        _$ResolutionEntityImpl instance) =>
    <String, dynamic>{
      'resolutionId': instance.resolutionId,
      'goalStatement': instance.goalStatement,
      'actionStatement': instance.actionStatement,
      'isActive': instance.isActive,
      'actionPerWeek': instance.actionPerWeek,
      'startDate': instance.startDate?.toIso8601String(),
      'shareFriendEntityList': instance.shareFriendEntityList,
      'shareGroupEntityList': instance.shareGroupEntityList,
    };
