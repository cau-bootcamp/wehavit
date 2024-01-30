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
      recentStrike: json['recentStrike'] as int?,
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdAt'], const TimestampConverter().fromJson),
      updatedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['updatedAt'], const TimestampConverter().fromJson),
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
      'recentStrike': instance.recentStrike,
      'createdAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.createdAt, const TimestampConverter().toJson),
      'updatedAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.updatedAt, const TimestampConverter().toJson),
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
