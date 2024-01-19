import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';

part 'firebase_confirm_post_model.g.dart';
part 'firebase_confirm_post_model.freezed.dart';

@freezed
class FirebaseConfirmPostModel with _$FirebaseConfirmPostModel {
  // ignore: invalid_annotation_target
  @JsonSerializable()
  const factory FirebaseConfirmPostModel({
    required String? resolutionGoalStatement,
    required String? resolutionId,
    required String? title,
    required String? content,
    required String? imageUrl,
    required String? owner,
    required List<String>? fan,
    required int? recentStrike,
    @TimestampConverter() required DateTime? createdAt,
    @TimestampConverter() required DateTime? updatedAt,
    required Map<String, bool>? attributes,
  }) = _FirebaseConfirmPostModel;

  factory FirebaseConfirmPostModel.fromJson(Map<String, dynamic> json) =>
      _$FirebaseConfirmPostModelFromJson(json);

  factory FirebaseConfirmPostModel.fromFireStoreDocument(DocumentSnapshot doc) {
    if (doc.data() == null) throw Exception('Document data was null');

    return FirebaseConfirmPostModel.fromJson(doc.data() as Map<String, Object?>)
        .copyWith();
  }

  factory FirebaseConfirmPostModel.fromConfirmPostEntity(
    ConfirmPostEntity entity,
  ) {
    return FirebaseConfirmPostModel(
      resolutionGoalStatement: entity.resolutionGoalStatement,
      resolutionId: entity.resolutionId,
      title: entity.title,
      content: entity.content,
      imageUrl: entity.imageUrl,
      owner: entity.owner,
      fan: entity.fan!.map((entity) => entity.userId!).toList(),
      recentStrike: entity.recentStrike,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      attributes: entity.attributes,
    );
  }
}

extension FirebaseConfirmPostModelConvert on FirebaseConfirmPostModel {
  ConfirmPostEntity toConfirmPostEntity(
    String postId,
    List<UserDataEntity> fanList,
    UserDataEntity owner,
  ) {
    return ConfirmPostEntity(
      id: postId,
      userName: owner.userName,
      userImageUrl: owner.userImageUrl,
      resolutionGoalStatement: resolutionGoalStatement,
      resolutionId: resolutionId,
      title: title,
      content: content,
      imageUrl: imageUrl,
      owner: owner.userId,
      fan: fanList,
      recentStrike: recentStrike,
      createdAt: createdAt,
      updatedAt: updatedAt,
      attributes: attributes,
    );
  }

  Map<String, dynamic> toFirestoreMap() {
    Map<String, dynamic> result = toJson();
    result[FirebaseConfirmPostFieldName.updatedAt] =
        Timestamp.fromDate(updatedAt!);
    result[FirebaseConfirmPostFieldName.createdAt] =
        Timestamp.fromDate(createdAt!);

    return result;
  }
}
