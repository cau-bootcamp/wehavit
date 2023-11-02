// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfirmPostModelImpl _$$ConfirmPostModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ConfirmPostModelImpl(
      resolutionGoalStatement: json['resolutionGoalStatement'] as String?,
      resolutionId:
          const DocumentReferenceJsonConverter().fromJson(json['resolutionId']),
      title: json['title'] as String?,
      content: json['content'] as String?,
      imageUrl: json['imageUrl'] as String?,
      recentStrike: json['recentStrike'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      roles: (json['roles'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      attributes: (json['attributes'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as bool),
      ),
    );

Map<String, dynamic> _$$ConfirmPostModelImplToJson(
        _$ConfirmPostModelImpl instance) =>
    <String, dynamic>{
      'resolutionGoalStatement': instance.resolutionGoalStatement,
      'resolutionId':
          const DocumentReferenceJsonConverter().toJson(instance.resolutionId),
      'title': instance.title,
      'content': instance.content,
      'imageUrl': instance.imageUrl,
      'recentStrike': instance.recentStrike,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'roles': instance.roles,
      'attributes': instance.attributes,
    };
