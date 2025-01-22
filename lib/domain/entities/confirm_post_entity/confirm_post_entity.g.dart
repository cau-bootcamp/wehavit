// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_post_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfirmPostEntityImpl _$$ConfirmPostEntityImplFromJson(Map<String, dynamic> json) => _$ConfirmPostEntityImpl(
      resolutionGoalStatement: json['resolutionGoalStatement'] as String? ?? '',
      resolutionId: json['resolutionId'] as String? ?? '',
      content: json['content'] as String? ?? '',
      imageUrlList: (json['imageUrlList'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      owner: json['owner'] as String? ?? '',
      recentStrike: (json['recentStrike'] as num?)?.toInt() ?? 0,
      createdAt: const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt'] as Timestamp),
      hasRested: json['hasRested'] as bool? ?? false,
    );

Map<String, dynamic> _$$ConfirmPostEntityImplToJson(_$ConfirmPostEntityImpl instance) => <String, dynamic>{
      'resolutionGoalStatement': instance.resolutionGoalStatement,
      'resolutionId': instance.resolutionId,
      'content': instance.content,
      'imageUrlList': instance.imageUrlList,
      'owner': instance.owner,
      'recentStrike': instance.recentStrike,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'hasRested': instance.hasRested,
    };
