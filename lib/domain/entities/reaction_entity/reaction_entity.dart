import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reaction_entity.freezed.dart';
part 'reaction_entity.g.dart';

@freezed
class ReactionEntity with _$ReactionEntity {
  factory ReactionEntity({
    // ignore: invalid_annotation_target
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default('')
    String? id,
    required String complimenterUid,
    required int reactionType,
    @Default(false) bool hasRead,
    @Default('') String instantPhotoUrl,
    @Default('') String comment,
    @Default({}) Map<String, int> emoji,
  }) = _ReactionEntity;

  factory ReactionEntity.fromJson(Map<String, dynamic> json) =>
      _$ReactionEntityFromJson(json);

  factory ReactionEntity.fromFireStoreDocument(DocumentSnapshot doc) {
    if (doc.data() == null) throw Exception('Document data was null');
    return ReactionEntity.fromJson(doc.data() as Map<String, Object?>)
        .copyWith(id: doc.id);
  }
}

enum ReactionType {
  instantPhoto,
  emoji,
  comment,
}
