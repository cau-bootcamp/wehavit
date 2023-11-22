// ignore_for_file: invalid_annotation_target
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_post_model.freezed.dart';
part 'confirm_post_model.g.dart';

@freezed
class ConfirmPostModel with _$ConfirmPostModel {
  @Assert(
    'resolutionGoalStatement != null',
    'resolutionGoalStatement must not be null',
  )
  @Assert(
    'resolutionGoalStatement!.isNotEmpty',
    'resolutionGoalStatement must not be empty',
  )
  @Assert('recentStrike != null', 'recentStrike must not be null')
  @Assert(
    'recentStrike! >= 0 && recentStrike! <= 170',
    'recentStrike must be between b0000000 and b1111111',
  )
  @Assert('createdAt != null', 'createdAt must not be null')
  @Assert('updatedAt != null', 'createdAt must not be null')
  @Assert('fan != null', 'roles(fan) must not be null')
  @Assert('owner != null', 'roles(owner) must not be null')
  @Assert('attributes != null', 'attribute must not be null')
  @TimestampConverter()
  @DocumentReferenceJsonConverter()
  factory ConfirmPostModel({
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default('')
    String? id,
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
  }) = _ConfirmPostModel;

  factory ConfirmPostModel.fromJson(Map<String, dynamic> json) =>
      _$ConfirmPostModelFromJson(json);

  factory ConfirmPostModel.fromFireStoreDocument(DocumentSnapshot doc) {
    if (doc.data() == null) throw Exception('Document data was null');

    return ConfirmPostModel.fromJson(doc.data() as Map<String, Object?>)
        .copyWith(id: doc.id);
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
