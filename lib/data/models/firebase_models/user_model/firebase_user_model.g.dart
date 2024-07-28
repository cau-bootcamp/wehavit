// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FirebaseUserModelImpl _$$FirebaseUserModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FirebaseUserModelImpl(
      handle: json['handle'] as String?,
      displayName: json['displayName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      aboutMe: json['aboutMe'] as String?,
      messageToken: json['messageToken'] as String?,
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdAt'], const TimestampConverter().fromJson),
      cumulativeGoals: (json['cumulativeGoals'] as num?)?.toInt(),
      cumulativePosts: (json['cumulativePosts'] as num?)?.toInt(),
      cumulativeReactions: (json['cumulativeReactions'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$FirebaseUserModelImplToJson(
        _$FirebaseUserModelImpl instance) =>
    <String, dynamic>{
      'handle': instance.handle,
      'displayName': instance.displayName,
      'imageUrl': instance.imageUrl,
      'aboutMe': instance.aboutMe,
      'messageToken': instance.messageToken,
      'createdAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.createdAt, const TimestampConverter().toJson),
      'cumulativeGoals': instance.cumulativeGoals,
      'cumulativePosts': instance.cumulativePosts,
      'cumulativeReactions': instance.cumulativeReactions,
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
