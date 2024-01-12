import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';

part 'firebase_confirm_post_model.g.dart';
part 'firebase_confirm_post_model.freezed.dart';

@freezed
class FirebaseConfirmPostModel with _$FirebaseConfirmPostModel {
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
    required DateTime? createdAt,
    required DateTime? updatedAt,
    required Map<String, bool>? attributes,
  }) = _FirebaseConfirmPostModel;

  factory FirebaseConfirmPostModel.fromJson(Map<String, dynamic> json) =>
      _$FirebaseConfirmPostModelFromJson(json);

  factory FirebaseConfirmPostModel.fromFireStoreDocument(DocumentSnapshot doc) {
    if (doc.data() == null) throw Exception('Document data was null');

    return FirebaseConfirmPostModel.fromJson(doc.data() as Map<String, Object?>)
        .copyWith();
  }

  ConfirmPostEntity toConfirmPostEntity() {
    return ConfirmPostEntity.fromJson(this.toJson());
  }
}
