import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';

// part 'resolution_entity.freezed.dart';
// part 'resolution_entity.g.dart';

// @freezed
class ResolutionEntity {
  ResolutionEntity({
    this.goalStatement,
    this.actionStatement,
    this.oathStatement,
    this.fanList,
    this.isDaySelectedList,
    this.resolutionId,
    this.isActive,
    this.startDate,
  });

  String? goalStatement;
  String? actionStatement;
  String? oathStatement;
  List<bool>? isDaySelectedList;
  List<UserDataEntity>? fanList = [];
  String? resolutionId;
  bool? isActive;
  DateTime? startDate;

  ResolutionEntity.fromMapData(
    Map<String, dynamic> data,
    this.resolutionId,
  )   : goalStatement =
            data[FirebaseResolutionFieldName.resolutionGoalStatement],
        actionStatement =
            data[FirebaseResolutionFieldName.resolutionActionStatement],
        isDaySelectedList = data[FirebaseResolutionFieldName.resolutionPeriod],
        startDate =
            (data[FirebaseResolutionFieldName.resolutionStartDate] as Timestamp)
                .toDate(),
        isActive = data[FirebaseResolutionFieldName.resolutionIsActive],
        oathStatement =
            data[FirebaseResolutionFieldName.resolutionOathStatement],
        fanList = data[FirebaseResolutionFieldName.resolutionFanList];

  ResolutionEntity.fromFirebaseDocument(
    Map<String, dynamic> data,
    this.resolutionId,
  )   : goalStatement =
            data[FirebaseResolutionFieldName.resolutionGoalStatement],
        actionStatement =
            data[FirebaseResolutionFieldName.resolutionActionStatement],
        isDaySelectedList = data[FirebaseResolutionFieldName.resolutionPeriod],
        startDate =
            (data[FirebaseResolutionFieldName.resolutionStartDate] as Timestamp)
                .toDate(),
        isActive = data[FirebaseResolutionFieldName.resolutionIsActive],
        oathStatement =
            data[FirebaseResolutionFieldName.resolutionOathStatement],
        fanList = (data[FirebaseResolutionFieldName.resolutionFanList] ?? [])
            .cast<String>()
            .toList();

  ResolutionEntity copyWith({
    List<bool>? isDaySelectedList,
    String? goalStatement,
    String? actionStatement,
    String? oathStatement,
    bool? isActive,
    DateTime? startDate,
    String? resolutionId,
    List<UserDataEntity>? fanList,
  }) {
    return ResolutionEntity(
      goalStatement: goalStatement ?? this.goalStatement,
      actionStatement: actionStatement ?? this.actionStatement,
      oathStatement: oathStatement ?? this.oathStatement,
      isDaySelectedList: isDaySelectedList ?? this.isDaySelectedList,
      isActive: isActive ?? this.isActive,
      startDate: startDate ?? this.startDate,
      resolutionId: resolutionId ?? this.resolutionId,
      fanList: fanList ?? this.fanList,
    );
  }
}

extension ResolutionEntityConvertFunctions on ResolutionEntity {
  /// Firebase Document로 Entity를 변환
  Map<String, dynamic> toFirebaseDocument() {
    final Map<String, dynamic> doc = {};

    doc[FirebaseResolutionFieldName.resolutionGoalStatement] = goalStatement;
    doc[FirebaseResolutionFieldName.resolutionActionStatement] =
        actionStatement;
    doc[FirebaseResolutionFieldName.resolutionPeriod] = isDaySelectedList;
    doc[FirebaseResolutionFieldName.resolutionStartDate] = startDate;
    doc[FirebaseResolutionFieldName.resolutionIsActive] = isActive;
    doc[FirebaseResolutionFieldName.resolutionFanList] = fanList;

    return doc;
  }

  ResolutionEntity toResolutionEntity() {
    final entity = ResolutionEntity(
      isActive: isActive,
      goalStatement: goalStatement,
      actionStatement: actionStatement,
      isDaySelectedList: isDaySelectedList,
      startDate: startDate,
      oathStatement: '',
      resolutionId: resolutionId,
      fanList: fanList,
    );
    return entity;
  }
}
