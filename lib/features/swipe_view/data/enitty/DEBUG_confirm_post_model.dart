import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@DocumentReferenceJsonConverter()
class ConfirmPostModel {
  ConfirmPostModel({
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
  });
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
