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
    required String? content,
    required List<String>? imageUrlList,
    required String? owner,
    required int? recentStrike,
    @TimestampConverter() required DateTime? createdAt,
    @TimestampConverter() required DateTime? updatedAt,
    required Map<String, bool>? attributes,
  }) = _FirebaseConfirmPostModel;

  factory FirebaseConfirmPostModel.fromJson(Map<String, dynamic> json) => _$FirebaseConfirmPostModelFromJson(json);

  factory FirebaseConfirmPostModel.fromFireStoreDocument(DocumentSnapshot doc) {
    if (doc.data() == null) throw Exception('Document data was null');

    return FirebaseConfirmPostModel.fromJson(doc.data() as Map<String, Object?>).copyWith();
  }

  factory FirebaseConfirmPostModel.fromConfirmPostEntity(
    ConfirmPostEntity entity,
  ) {
    return FirebaseConfirmPostModel(
      resolutionGoalStatement: entity.resolutionGoalStatement,
      resolutionId: entity.resolutionId,
      content: entity.content,
      imageUrlList: entity.imageUrlList,
      owner: entity.owner,
      recentStrike: entity.recentStrike,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      attributes: {
        FirebaseConfirmPostFieldName.attributesHasRested: entity.hasRested,
      },
    );
  }
}

extension FirebaseConfirmPostModelConvert on FirebaseConfirmPostModel {
  ConfirmPostEntity toConfirmPostEntity(
    String postId,
    UserDataEntity owner,
  ) {
    return ConfirmPostEntity(
      id: postId,
      userName: owner.userName,
      userImageUrl: owner.userImageUrl,
      resolutionGoalStatement: resolutionGoalStatement ?? '',
      resolutionId: resolutionId ?? '',
      content: content ?? '',
      imageUrlList: imageUrlList ?? [],
      owner: owner.userId,
      recentStrike: recentStrike ?? 0,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
      hasRested: attributes?[FirebaseConfirmPostFieldName.attributesHasRested] ?? false,
    );
  }

  Map<String, dynamic> toFirestoreMap() {
    Map<String, dynamic> result = toJson();
    result[FirebaseConfirmPostFieldName.updatedAt] = Timestamp.fromDate(updatedAt!);
    result[FirebaseConfirmPostFieldName.createdAt] = Timestamp.fromDate(createdAt!);

    return result;
  }
}
