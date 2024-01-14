import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wehavit/common/utils/timestamp_serializer.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_entity.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';

part 'firebase_resolution_model.g.dart';
part 'firebase_resolution_model.freezed.dart';

@freezed
class FirebaseResolutionModel with _$FirebaseResolutionModel {
  @JsonSerializable()
  const factory FirebaseResolutionModel({
    required String? goalStatement,
    required String? actionStatement,
    required bool? isActive,
    required int? actionPerWeek,
    @TimestampSerializer() required DateTime? startDate,
    required List<String>? fanUserIdList,
    required String? documentId,
  }) = _FirebaseResolutionModel;

  factory FirebaseResolutionModel.fromJson(Map<String, dynamic> json) =>
      _$FirebaseResolutionModelFromJson(json);

  factory FirebaseResolutionModel.fromFireStoreDocument(DocumentSnapshot doc) {
    if (doc.data() == null) throw Exception('Document data was null');

    return FirebaseResolutionModel.fromJson(doc.data() as Map<String, Object?>)
        .copyWith();
  }
}

extension ConvertFirebaseResolutionModel on FirebaseResolutionModel {
  ResolutionEntity toResolutionEntity(
    List<UserDataEntity> fanUserEntityList,
  ) {
    return ResolutionEntity(
      resolutionId: documentId,
      goalStatement: goalStatement,
      actionStatement: actionStatement,
      isActive: isActive,
      actionPerWeek: actionPerWeek,
      startDate: startDate,
      fanList: fanUserEntityList,
    );
  }
}
