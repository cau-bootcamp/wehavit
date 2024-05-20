// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FirebaseUserModelImpl _$$FirebaseUserModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FirebaseUserModelImpl(
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      aboutMe: json['aboutMe'] as String?,
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdAt'], const TimestampConverter().fromJson),
      cumulativeGoals: json['cumulativeGoals'] as int?,
      cumulativePosts: json['cumulativePosts'] as int?,
      cumulativeReactions: json['cumulativeReactions'] as int?,
    );

Map<String, dynamic> _$$FirebaseUserModelImplToJson(
        _$FirebaseUserModelImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'displayName': instance.displayName,
      'imageUrl': instance.imageUrl,
      'aboutMe': instance.aboutMe,
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
