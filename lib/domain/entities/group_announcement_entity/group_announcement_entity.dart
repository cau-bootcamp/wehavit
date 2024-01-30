// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wehavit/domain/entities/entities.dart';

part 'group_announcement_entity.freezed.dart';
part 'group_announcement_entity.g.dart';

@freezed
class GroupAnnouncementEntity with _$GroupAnnouncementEntity {
  @JsonSerializable()
  factory GroupAnnouncementEntity({
    required String groupId,
    required String writerUid,
    required String title,
    required String content,
    @TimestampConverter() required DateTime createdAt,
    required List<String> readByUidList,
    @JsonKey(includeFromJson: true, includeToJson: false)
    required String groupAnnouncementId,
  }) = _GroupAnnouncementEntity;

  factory GroupAnnouncementEntity.fromJson(Map<String, dynamic> json) =>
      _$GroupAnnouncementEntityFromJson(json);
}
