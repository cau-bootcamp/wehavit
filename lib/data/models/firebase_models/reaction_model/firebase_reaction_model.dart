import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wehavit/domain/entities/entities.dart';

part 'firebase_reaction_model.g.dart';
part 'firebase_reaction_model.freezed.dart';

@freezed
class FirebaseReactionModel with _$FirebaseReactionModel {
  // ignore: invalid_annotation_target
  @JsonSerializable()
  const factory FirebaseReactionModel({
    required String complimenterUid,
    required int reactionType,
    required String quickShotUrl,
    required String comment,
    required Map<String, int> emoji,
  }) = _FirebaseReactionModel;

  factory FirebaseReactionModel.fromJson(Map<String, dynamic> json) => _$FirebaseReactionModelFromJson(json);

  factory FirebaseReactionModel.fromFireStoreDocument(DocumentSnapshot doc) {
    if (doc.data() == null) throw Exception('Document data was null');

    return FirebaseReactionModel.fromJson(doc.data() as Map<String, Object?>);
  }

  factory FirebaseReactionModel.fromReactionEntity(ReactionEntity entity) => FirebaseReactionModel(
        complimenterUid: entity.complimenterUid,
        reactionType: entity.reactionType,
        quickShotUrl: entity.quickShotUrl,
        comment: entity.comment,
        emoji: entity.emoji,
      );
}

extension ConvertFirebaseReactionModel on FirebaseReactionModel {
  ReactionEntity toReactionEntity() {
    return ReactionEntity.fromJson(toJson());
  }
}
