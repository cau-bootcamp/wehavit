// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_quickshot_preset_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FirebaseQuickshotPresetModelImpl _$$FirebaseQuickshotPresetModelImplFromJson(Map<String, dynamic> json) =>
    _$FirebaseQuickshotPresetModelImpl(
      url: json['url'] as String,
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(json['createdAt'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$$FirebaseQuickshotPresetModelImplToJson(_$FirebaseQuickshotPresetModelImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'createdAt': _$JsonConverterToJson<Timestamp, DateTime>(instance.createdAt, const TimestampConverter().toJson),
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
