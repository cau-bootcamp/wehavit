import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wehavit/domain/entities/entities.dart';

part 'firebase_resolution_model.g.dart';
part 'firebase_resolution_model.freezed.dart';

@freezed
class FirebaseResolutionModel with _$FirebaseResolutionModel {
  // ignore: invalid_annotation_target
  @JsonSerializable()
  const factory FirebaseResolutionModel({
    required String? resolutionName,
    required String? goalStatement,
    required String? actionStatement,
    required bool? isActive,
    required int? colorIndex,
    required int? iconIndex,
    required int? actionPerWeek,
    @TimestampConverter() required DateTime? startDate,
    required List<String>? shareFriendIdList,
    required List<String>? shareGroupIdList,
  }) = _FirebaseResolutionModel;

  factory FirebaseResolutionModel.fromJson(Map<String, dynamic> json) =>
      _$FirebaseResolutionModelFromJson(json);

  factory FirebaseResolutionModel.fromFireStoreDocument(DocumentSnapshot doc) {
    if (doc.data() == null) throw Exception('Document data was null');

    return FirebaseResolutionModel.fromJson(doc.data() as Map<String, Object?>);
  }

  factory FirebaseResolutionModel.fromEntity(ResolutionEntity entity) =>
      FirebaseResolutionModel(
        resolutionName: entity.resolutionName,
        goalStatement: entity.goalStatement,
        actionStatement: entity.actionStatement,
        isActive: entity.isActive,
        actionPerWeek: entity.actionPerWeek,
        startDate: entity.startDate,
        colorIndex: entity.colorIndex,
        iconIndex: entity.iconIndex,
        shareFriendIdList: entity.shareFriendEntityList
                ?.map((friendEntity) => friendEntity.userId!)
                .toList() ??
            [],
        shareGroupIdList: entity.shareGroupEntityList
                ?.map((groupEntity) => groupEntity.groupId)
                .toList() ??
            [],
      );
}

extension ConvertFirebaseResolutionModel on FirebaseResolutionModel {
  ResolutionEntity toResolutionEntity({
    required String documentId,
    required List<UserDataEntity> shareFriendEntityList,
    required List<GroupEntity> shareGroupEntityList,
  }) {
    return ResolutionEntity(
      resolutionName: resolutionName,
      resolutionId: documentId,
      goalStatement: goalStatement,
      actionStatement: actionStatement,
      isActive: isActive,
      colorIndex: colorIndex,
      iconIndex: iconIndex,
      actionPerWeek: actionPerWeek,
      startDate: startDate,
      shareFriendEntityList: shareFriendEntityList,
      shareGroupEntityList: shareGroupEntityList,
    );
  }
}
