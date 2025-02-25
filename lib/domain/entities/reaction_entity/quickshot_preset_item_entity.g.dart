// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quickshot_preset_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuickshotPresetItemEntityImpl _$$QuickshotPresetItemEntityImplFromJson(Map<String, dynamic> json) =>
    _$QuickshotPresetItemEntityImpl(
      url: json['url'] as String? ?? '',
      id: json['id'] as String? ?? '',
      createdAt: const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$$QuickshotPresetItemEntityImplToJson(_$QuickshotPresetItemEntityImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'id': instance.id,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
