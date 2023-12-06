// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waiting_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WaitingUserImpl _$$WaitingUserImplFromJson(Map<String, dynamic> json) =>
    _$WaitingUserImpl(
      updatedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['updatedAt'], const TimestampConverter().fromJson),
      userId: json['userId'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$WaitingUserImplToJson(_$WaitingUserImpl instance) =>
    <String, dynamic>{
      'updatedAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.updatedAt, const TimestampConverter().toJson),
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'imageUrl': instance.imageUrl,
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
