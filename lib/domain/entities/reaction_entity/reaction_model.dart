import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reaction_model.freezed.dart';
part 'reaction_model.g.dart';

@freezed
class ReactionModel with _$ReactionModel {
  factory ReactionModel({
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
  }) = _ReactionModel;

  factory ReactionModel.fromJson(Map<String, dynamic> json) =>
      _$ReactionModelFromJson(json);

  factory ReactionModel.fromFireStoreDocument(DocumentSnapshot doc) {
    if (doc.data() == null) throw Exception('Document data was null');
    return ReactionModel.fromJson(doc.data() as Map<String, Object?>)
        .copyWith(id: doc.id);
  }
}

enum ReactionType {
  instantPhoto,
  emoji,
  comment,
}
