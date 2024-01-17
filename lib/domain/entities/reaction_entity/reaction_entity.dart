import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reaction_entity.freezed.dart';
part 'reaction_entity.g.dart';

@freezed
class ReactionEntity with _$ReactionEntity {
  factory ReactionEntity({
    required String confirmPostId,
    required String complimenterUid,
    required int reactionType,
    @Default('') String instantPhotoUrl,
    @Default('') String comment,
    @Default({}) Map<String, int> emoji,
  }) = _ReactionEntity;

  factory ReactionEntity.emojiType({
    required String confirmPostId,
    required String complimenterUid,
    required Map<String, int> emoji,
  }) =>
      ReactionEntity(
        confirmPostId: confirmPostId,
        complimenterUid: complimenterUid,
        reactionType: ReactionType.emoji.index,
        emoji: emoji,
      );

  factory ReactionEntity.quickShotType({
    required String confirmPostId,
    required String complimenterUid,
    required String instantPhotoUrl,
  }) =>
      ReactionEntity(
        confirmPostId: confirmPostId,
        complimenterUid: complimenterUid,
        reactionType: ReactionType.quickShot.index,
        instantPhotoUrl: instantPhotoUrl,
      );

  factory ReactionEntity.comment({
    required String confirmPostId,
    required String complimenterUid,
    required String comment,
  }) =>
      ReactionEntity(
        confirmPostId: confirmPostId,
        complimenterUid: complimenterUid,
        reactionType: ReactionType.comment.index,
        comment: comment,
      );

  factory ReactionEntity.fromJson(Map<String, dynamic> json) =>
      _$ReactionEntityFromJson(json);

  factory ReactionEntity.fromFireStoreDocument(DocumentSnapshot doc) {
    if (doc.data() == null) throw Exception('Document data was null');
    return ReactionEntity.fromJson(doc.data() as Map<String, Object?>);
  }
}

enum ReactionType {
  quickShot,
  emoji,
  comment,
}
