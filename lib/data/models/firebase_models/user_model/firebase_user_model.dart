import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wehavit/domain/entities/entities.dart';

part 'firebase_user_model.g.dart';
part 'firebase_user_model.freezed.dart';

@freezed
class FirebaseUserModel with _$FirebaseUserModel {
  // ignore: invalid_annotation_target
  @JsonSerializable()
  const factory FirebaseUserModel({
    String? handle,
    String? displayName,
    String? imageUrl,
    String? aboutMe,
    @TimestampConverter() DateTime? createdAt,
    int? cumulativeGoals,
    int? cumulativePosts,
    int? cumulativeReactions,
  }) = _FirebaseUserModel;

  factory FirebaseUserModel.fromJson(Map<String, dynamic> json) =>
      _$FirebaseUserModelFromJson(json);

  factory FirebaseUserModel.fromFireStoreDocument(DocumentSnapshot doc) {
    if (doc.data() == null) throw Exception('Document data was null');

    return FirebaseUserModel.fromJson(doc.data() as Map<String, Object?>)
        .copyWith();
  }
}

extension ConvertFirebaseUserModel on FirebaseUserModel {
  UserDataEntity toUserDataEntity({
    required String userId,
  }) {
    return UserDataEntity(
      handle: handle,
      userImageUrl: imageUrl,
      userName: displayName,
      userId: userId,
      aboutMe: aboutMe,
      createdAt: createdAt,
      cumulativeGoals: cumulativeGoals,
      cumulativePosts: cumulativePosts,
      cumulativeReactions: cumulativeReactions,
    );
  }
}
