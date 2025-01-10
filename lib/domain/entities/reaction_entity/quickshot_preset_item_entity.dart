import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wehavit/domain/entities/entities.dart';

part 'quickshot_preset_item_entity.freezed.dart';
part 'quickshot_preset_item_entity.g.dart';

@freezed
class QuickshotPresetItemEntity with _$QuickshotPresetItemEntity {
  // ignore: invalid_annotation_target
  @JsonSerializable()
  @TimestampConverter()
  factory QuickshotPresetItemEntity({
    @Default('') String url,
    @Default('') String id,
    required DateTime createdAt,
  }) = _QuickshotPresetItemEntity;

  factory QuickshotPresetItemEntity.fromJson(Map<String, dynamic> json) => _$QuickshotPresetItemEntityFromJson(json);
}
