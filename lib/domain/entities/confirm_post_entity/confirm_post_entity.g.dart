// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_post_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfirmPostEntityImpl _$$ConfirmPostEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$ConfirmPostEntityImpl(
      resolutionGoalStatement: json['resolutionGoalStatement'] as String?,
      resolutionId: json['resolutionId'] as String?,
      content: json['content'] as String?,
      imageUrlList: (json['imageUrlList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      owner: json['owner'] as String?,
      recentStrike: json['recentStrike'] as int?,
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdAt'], const TimestampConverter().fromJson),
      updatedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['updatedAt'], const TimestampConverter().fromJson),
      hasRested: json['hasRested'] as bool? ?? false,
    );

Map<String, dynamic> _$$ConfirmPostEntityImplToJson(
        _$ConfirmPostEntityImpl instance) =>
    <String, dynamic>{
      'resolutionGoalStatement': instance.resolutionGoalStatement,
      'resolutionId': instance.resolutionId,
      'content': instance.content,
      'imageUrlList': instance.imageUrlList,
      'owner': instance.owner,
      'recentStrike': instance.recentStrike,
      'createdAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.createdAt, const TimestampConverter().toJson),
      'updatedAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.updatedAt, const TimestampConverter().toJson),
      'hasRested': instance.hasRested,
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
