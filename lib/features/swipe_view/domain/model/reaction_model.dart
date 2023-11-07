import 'package:freezed_annotation/freezed_annotation.dart';

part 'reaction_model.freezed.dart';
part 'reaction_model.g.dart';

@freezed
class ReactionModel with _$ReactionModel {
  factory ReactionModel({
    required String complementerUid,
    required bool hasRead,
    required String instantPhotoUrl,
    required int reactionType,
    required String comment,
    required Map<String, int> emoji,
  }) = _ReactionModel;

  factory ReactionModel.fromJson(Map<String, dynamic> json) =>
      _$ReactionModelFromJson(json);
}

enum ReactionType {
  instantPhoto,
  emoji,
  comment,
}
