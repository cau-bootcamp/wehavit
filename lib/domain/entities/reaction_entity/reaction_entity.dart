import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reaction_entity.freezed.dart';
part 'reaction_entity.g.dart';

@freezed
class ReactionEntity with _$ReactionEntity {
  // ignore: invalid_annotation_target
  @JsonSerializable()
  factory ReactionEntity({
    @Default('') String confirmPostId,
    required String complimenterUid,
    required int reactionType,
    @Default('') String quickShotUrl,
    @Default('') String comment,
    @Default({}) Map<String, int> emoji,
  }) = _ReactionEntity;

  factory ReactionEntity.emojiType({
    required String complimenterUid,
    required Map<String, int> emoji,
  }) =>
      ReactionEntity(
        complimenterUid: complimenterUid,
        reactionType: ReactionType.emoji.index,
        emoji: emoji,
      );

  factory ReactionEntity.quickShotType({
    required String complimenterUid,
    required String quickShotUrl,
  }) =>
      ReactionEntity(
        complimenterUid: complimenterUid,
        reactionType: ReactionType.quickShot.index,
        quickShotUrl: quickShotUrl,
      );

  factory ReactionEntity.commentType({
    required String complimenterUid,
    required String comment,
  }) =>
      ReactionEntity(
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
