import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wehavit/domain/entities/entities.dart';

part 'firebase_group_model.freezed.dart';
part 'firebase_group_model.g.dart';

@freezed
class FirebaseGroupModel with _$FirebaseGroupModel {
  // ignore: invalid_annotation_target
  @JsonSerializable()
  factory FirebaseGroupModel({
    required String groupName,
    required String groupDescription,
    required String groupRule,
    required String groupManagerUid,
    required int groupColor,
    required List<String> groupMemberUidList,
    @TimestampConverter() required DateTime groupCreatedAt,
  }) = _FirebaseGroupModel;

  factory FirebaseGroupModel.fromJson(Map<String, dynamic> json) =>
      _$FirebaseGroupModelFromJson(json);

  factory FirebaseGroupModel.fromFireStoreDocument(DocumentSnapshot doc) {
    if (doc.data() == null) throw Exception('Document data was null');

    return FirebaseGroupModel.fromJson(doc.data() as Map<String, Object?>);
  }
}

extension FirebaseGroupModelConverter on FirebaseGroupModel {
  GroupEntity toGroupEntity({required String groupId}) {
    return GroupEntity(
      groupName: groupName,
      groupDescription: groupDescription,
      groupRule: groupRule,
      groupManagerUid: groupManagerUid,
      groupMemberUidList: groupMemberUidList,
      groupId: groupId,
      groupColor: groupColor,
      groupCreatedAt: groupCreatedAt,
    );
  }
}
