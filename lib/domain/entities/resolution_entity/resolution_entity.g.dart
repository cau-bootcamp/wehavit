// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resolution_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResolutionEntityImpl _$$ResolutionEntityImplFromJson(Map<String, dynamic> json) => _$ResolutionEntityImpl(
      resolutionId: json['resolutionId'] as String? ?? '',
      resolutionName: json['resolutionName'] as String? ?? '',
      goalStatement: json['goalStatement'] as String? ?? '',
      actionStatement: json['actionStatement'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? false,
      actionPerWeek: (json['actionPerWeek'] as num?)?.toInt() ?? 0,
      colorIndex: (json['colorIndex'] as num?)?.toInt() ?? 0,
      iconIndex: (json['iconIndex'] as num?)?.toInt() ?? 0,
      startDate: const TimestampConverter().fromJson(json['startDate'] as Timestamp),
      shareFriendEntityList: (json['shareFriendEntityList'] as List<dynamic>?)
              ?.map((e) => UserDataEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      shareGroupEntityList: (json['shareGroupEntityList'] as List<dynamic>?)
              ?.map((e) => GroupEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      writtenPostCount: (json['writtenPostCount'] as num?)?.toInt() ?? 0,
      receivedReactionCount: (json['receivedReactionCount'] as num?)?.toInt() ?? 0,
      successWeekMondayList: (json['successWeekMondayList'] as List<dynamic>?)
              ?.map((e) => const TimestampConverter().fromJson(e as Timestamp))
              .toList() ??
          const [],
      weeklyPostCountList:
          (json['weeklyPostCountList'] as List<dynamic>?)?.map((e) => (e as num).toInt()).toList() ?? const [],
    );

Map<String, dynamic> _$$ResolutionEntityImplToJson(_$ResolutionEntityImpl instance) => <String, dynamic>{
      'resolutionId': instance.resolutionId,
      'resolutionName': instance.resolutionName,
      'goalStatement': instance.goalStatement,
      'actionStatement': instance.actionStatement,
      'isActive': instance.isActive,
      'actionPerWeek': instance.actionPerWeek,
      'colorIndex': instance.colorIndex,
      'iconIndex': instance.iconIndex,
      'startDate': const TimestampConverter().toJson(instance.startDate),
      'shareFriendEntityList': instance.shareFriendEntityList,
      'shareGroupEntityList': instance.shareGroupEntityList,
      'writtenPostCount': instance.writtenPostCount,
      'receivedReactionCount': instance.receivedReactionCount,
      'successWeekMondayList': instance.successWeekMondayList.map(const TimestampConverter().toJson).toList(),
      'weeklyPostCountList': instance.weeklyPostCountList,
    };
