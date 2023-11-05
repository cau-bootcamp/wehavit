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
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdAt'], const TimestampConverter().fromJson),
      updatedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['updatedAt'], const TimestampConverter().fromJson),
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
      'createdAt': _$JsonConverterToJson<Timestamp, DateTime>(
        instance.createdAt,
        const TimestampConverter().toJson,
      ),
      'updatedAt': _$JsonConverterToJson<Timestamp, DateTime>(
        instance.updatedAt,
        const TimestampConverter().toJson,
      ),
      'roles': instance.roles,
      'attributes': instance.attributes,
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
