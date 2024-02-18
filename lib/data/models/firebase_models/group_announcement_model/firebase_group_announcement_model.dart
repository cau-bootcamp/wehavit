import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wehavit/domain/entities/entities.dart';

part 'firebase_group_announcement_model.freezed.dart';
part 'firebase_group_announcement_model.g.dart';

@freezed
class FirebaseGroupAnnouncementModel with _$FirebaseGroupAnnouncementModel {
  // ignore: invalid_annotation_target
  @JsonSerializable()
  factory FirebaseGroupAnnouncementModel({
    required String groupId,
    required String writerUid,
    required String title,
    required String content,
    @TimestampConverter() required DateTime createdAt,
    required List<String> readByUidList,
  }) = _FirebaseGroupAnnouncementModel;

  factory FirebaseGroupAnnouncementModel.fromJson(Map<String, dynamic> json) =>
      _$FirebaseGroupAnnouncementModelFromJson(json);

  factory FirebaseGroupAnnouncementModel.fromFireStoreDocument(
      DocumentSnapshot doc) {
    if (doc.data() == null) throw Exception('Document data was null');

    return FirebaseGroupAnnouncementModel.fromJson(
      doc.data() as Map<String, Object?>,
    );
  }

  factory FirebaseGroupAnnouncementModel.fromEntity(
    GroupAnnouncementEntity entity,
  ) {
    return FirebaseGroupAnnouncementModel(
      groupId: entity.groupId,
      writerUid: entity.writerUid,
      title: entity.title,
      content: entity.content,
      createdAt: entity.createdAt,
      readByUidList: entity.readByUidList,
    );
  }
}

extension FirebaseGroupAnnouncementModelConverter
    on FirebaseGroupAnnouncementModel {
  GroupAnnouncementEntity toEntity({required String announcementId}) {
    return GroupAnnouncementEntity(
      groupId: groupId,
      writerUid: writerUid,
      title: title,
      content: content,
      createdAt: createdAt,
      readByUidList: readByUidList,
      groupAnnouncementId: announcementId,
    );
  }
}
