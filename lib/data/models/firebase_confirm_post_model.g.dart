// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_confirm_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FirebaseConfirmPostModelImpl _$$FirebaseConfirmPostModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FirebaseConfirmPostModelImpl(
      resolutionGoalStatement: json['resolutionGoalStatement'] as String?,
      resolutionId: json['resolutionId'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      imageUrl: json['imageUrl'] as String?,
      owner: json['owner'] as String?,
      fan: (json['fan'] as List<dynamic>?)?.map((e) => e as String).toList(),
      recentStrike: json['recentStrike'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      attributes: (json['attributes'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as bool),
      ),
    );

Map<String, dynamic> _$$FirebaseConfirmPostModelImplToJson(
        _$FirebaseConfirmPostModelImpl instance) =>
    <String, dynamic>{
      'resolutionGoalStatement': instance.resolutionGoalStatement,
      'resolutionId': instance.resolutionId,
      'title': instance.title,
      'content': instance.content,
      'imageUrl': instance.imageUrl,
      'owner': instance.owner,
      'fan': instance.fan,
      'recentStrike': instance.recentStrike,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'attributes': instance.attributes,
    };
