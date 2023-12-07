// import 'package:cloud_firestore/cloud_firestore.dart';

// class ConfirmPostModel {
//   ConfirmPostModel({
//     // required this.postId,
//     required this.userImageUrl,
//     required this.userName,
//     required this.resolutionGoalStatement,
//     required this.title,
//     required this.content,
//     required this.contentImageUrl,
//     required this.postAt,
//   });

//   String userImageUrl;
//   String userName;
//   String resolutionGoalStatement;
//   String title;
//   String content;
//   String contentImageUrl;
//   Timestamp postAt;

//   ConfirmPostModel copyWith({
//     String? userImageUrl,
//     String? userName,
//     String? resolutionGoalStatement,
//     String? title,
//     String? content,
//     String? contentImageUrl,
//     Timestamp? postAt,
//   }) {
//     return ConfirmPostModel(
//       userImageUrl: userImageUrl ?? this.userImageUrl,
//       userName: userName ?? this.userName,
//       resolutionGoalStatement:
//           resolutionGoalStatement ?? this.resolutionGoalStatement,
//       title: title ?? this.title,
//       content: content ?? this.content,
//       contentImageUrl: contentImageUrl ?? this.contentImageUrl,
//       postAt: postAt ?? this.postAt,
//     );
//   }
// }

// ignore_for_file: invalid_annotation_target
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_post_model.freezed.dart';
part 'confirm_post_model.g.dart';

@freezed
class HomeConfirmPostModel with _$HomeConfirmPostModel {
  @TimestampConverter()
  @DocumentReferenceJsonConverter()
  factory HomeConfirmPostModel({
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default('')
    String? id,
    @Default('')
    @JsonKey(includeFromJson: false, includeToJson: false)
    String? userName,
    @Default('')
    @JsonKey(includeFromJson: false, includeToJson: false)
    String? userImageUrl,
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
  }) = _HomeConfirmPostModel;

  factory HomeConfirmPostModel.fromJson(Map<String, dynamic> json) =>
      _$HomeConfirmPostModelFromJson(json);

  factory HomeConfirmPostModel.fromFireStoreDocument(
      (String, String) userData, DocumentSnapshot doc) {
    if (doc.data() == null) throw Exception('Document data was null');

    return HomeConfirmPostModel.fromJson(doc.data() as Map<String, Object?>)
        .copyWith(id: doc.id, userName: userData.$2, userImageUrl: userData.$1);
  }
}

T? tryCast<T>(value) {
  return value == null ? null : value as T;
}

class DocumentReferenceJsonConverter
    implements
        JsonConverter<DocumentReference<Map<String, dynamic>>?, Object?> {
  const DocumentReferenceJsonConverter();

  @override
  DocumentReference<Map<String, dynamic>>? fromJson(Object? json) {
    return tryCast<DocumentReference<Map<String, dynamic>>>(json);
  }

  @override
  Object? toJson(DocumentReference? documentReference) => documentReference;
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
