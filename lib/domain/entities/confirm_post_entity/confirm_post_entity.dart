// ignore_for_file: invalid_annotation_target
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_post_entity.freezed.dart';
part 'confirm_post_entity.g.dart';

@freezed
class ConfirmPostEntity with _$ConfirmPostEntity {
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
  @Assert('owner != null', 'roles(owner) must not be null')
  @TimestampConverter()
  @DocumentReferenceJsonConverter()
  factory ConfirmPostEntity({
    @JsonKey(includeFromJson: false, includeToJson: false) @Default('') String? id,
    @Default('') @JsonKey(includeFromJson: false, includeToJson: false) String? userName,
    @Default('') @JsonKey(includeFromJson: false, includeToJson: false) String? userImageUrl,
    required String? resolutionGoalStatement,
    required String? resolutionId,
    required String? content,
    required List<String>? imageUrlList,
    required String? owner,
    required int? recentStrike,
    required DateTime? createdAt,
    required DateTime? updatedAt,
    @Default(false) bool hasRested,
  }) = _ConfirmPostEntity;

  factory ConfirmPostEntity.fromJson(Map<String, dynamic> json) => _$ConfirmPostEntityFromJson(json);
}

T? tryCast<T>(value) {
  return value == null ? null : value as T;
}

class DocumentReferenceJsonConverter implements JsonConverter<DocumentReference<Map<String, dynamic>>?, Object?> {
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

extension ConfirmPostEntityDummy on ConfirmPostEntity {
  static ConfirmPostEntity dummy = ConfirmPostEntity(
    resolutionGoalStatement: 'dummy goal statement',
    resolutionId: 'vR3lA2WTqm7wDC4ve1LN',
    content: 'content',
    imageUrlList: [],
    owner: '69dlXoGSBKhzrySuhb8t9MvqzdD3',
    recentStrike: 3,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}
