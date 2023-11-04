import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_post_model.freezed.dart';
part 'confirm_post_model.g.dart';

@freezed
class ConfirmPostModel with _$ConfirmPostModel {
  @Assert('resolutionGoalStatement != null',
      'resolutionGoalStatement must not be null')
  @Assert('resolutionGoalStatement!.isNotEmpty',
      'resolutionGoalStatement must not be empty')
  @Assert('recentStrike != null', 'recentStrike must not be null')
  @Assert('recentStrike! >= 0 && recentStrike! <= 170',
      'recentStrike must be between b0000000 and b1111111')
  @Assert('resolutionId != null', 'resolutionId must not be null')
  @Assert('createdAt != null', 'createdAt must not be empty')
  @Assert('updatedAt != null', 'createdAt must not be empty')
  @Assert('roles != null', 'roles must not be empty')
  @Assert('attributes != null', 'roles must not be empty')
  @TimestampConverter()
  @DocumentReferenceJsonConverter()
  factory ConfirmPostModel({
    required String? resolutionGoalStatement,
    required DocumentReference<Map<String, dynamic>>? resolutionId,
    required String? title,
    required String? content,
    required String? imageUrl,
    required int? recentStrike,
    required DateTime? createdAt,
    required DateTime? updatedAt,
    required Map<String, String>? roles,
    required Map<String, bool>? attributes,
  }) = _ConfirmPostModel;

  factory ConfirmPostModel.fromJson(Map<String, dynamic> json) =>
      _$ConfirmPostModelFromJson(json);
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
