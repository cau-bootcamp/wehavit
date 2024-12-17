// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quickshot_preset_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuickshotPresetItemEntityImpl _$$QuickshotPresetItemEntityImplFromJson(Map<String, dynamic> json) =>
    _$QuickshotPresetItemEntityImpl(
      url: json['url'] as String? ?? '',
      id: json['id'] as String? ?? '',
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(json['createdAt'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$$QuickshotPresetItemEntityImplToJson(_$QuickshotPresetItemEntityImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'id': instance.id,
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
