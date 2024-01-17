import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_entity.dart';

part 'firebase_reaction_model.g.dart';
part 'firebase_reaction_model.freezed.dart';

@freezed
class FirebaseReactionModel with _$FirebaseReactionModel {
  // ignore: invalid_annotation_target
  @JsonSerializable()
  const factory FirebaseReactionModel({
    required String complimenterUid,
    required int reactionType,
    required String instantPhotoUrl,
    required String comment,
    required Map<String, int> emoji,
  }) = _FirebaseReactionModel;

  factory FirebaseReactionModel.fromJson(Map<String, dynamic> json) =>
      _$FirebaseReactionModelFromJson(json);

  factory FirebaseReactionModel.fromFireStoreDocument(DocumentSnapshot doc) {
    if (doc.data() == null) throw Exception('Document data was null');

    return FirebaseReactionModel.fromJson(doc.data() as Map<String, Object?>);
  }
}

extension ConvertFirebaseReactionModel on FirebaseReactionModel {
  ReactionEntity toReactionEntity({required String fromConfirmPostId}) {
    return ReactionEntity.fromJson(toJson()).copyWith(
      confirmPostId: fromConfirmPostId,
    );
  }
}
