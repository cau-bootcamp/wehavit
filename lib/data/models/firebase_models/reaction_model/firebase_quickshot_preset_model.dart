import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wehavit/domain/entities/entities.dart';

part 'firebase_quickshot_preset_model.g.dart';
part 'firebase_quickshot_preset_model.freezed.dart';

@freezed
class FirebaseQuickshotPresetModel with _$FirebaseQuickshotPresetModel {
  // ignore: invalid_annotation_target
  @JsonSerializable()
  const factory FirebaseQuickshotPresetModel({
    required String url,
    @TimestampConverter() required DateTime? createdAt,
  }) = _FirebaseQuickshotPresetModel;

  factory FirebaseQuickshotPresetModel.fromJson(Map<String, dynamic> json) =>
      _$FirebaseQuickshotPresetModelFromJson(json);

  factory FirebaseQuickshotPresetModel.fromFireStoreDocument(
    DocumentSnapshot doc,
  ) {
    if (doc.data() == null) throw Exception('Document data was null');

    return FirebaseQuickshotPresetModel.fromJson(
      doc.data() as Map<String, Object?>,
    );
  }

  factory FirebaseQuickshotPresetModel.fromEntity(
    QuickshotPresetItemEntity entity,
  ) =>
      FirebaseQuickshotPresetModel(
        url: entity.url,
        createdAt: entity.createdAt,
      );
}

extension ConvertFirebaseQuickshotPresetModel on FirebaseQuickshotPresetModel {
  QuickshotPresetItemEntity toReactionEntity({required String docId}) {
    return QuickshotPresetItemEntity.fromJson(toJson()).copyWith(id: docId);
  }
}
