import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';

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
    return FirebaseConfirmPostModel.fromJson(entity.toJson());
  }
}

extension FirebaseConfirmPostModelConvert on FirebaseConfirmPostModel {
  ConfirmPostEntity toConfirmPostEntity() {
    return ConfirmPostEntity.fromJson(toJson());
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
