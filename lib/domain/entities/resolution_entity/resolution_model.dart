import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/domain/entities/user_data_entity/friend_model.dart';

class ResolutionModel {
  ResolutionModel({
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

  ResolutionModel.fromMapData(
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

  ResolutionModel copyWith({
    List<bool>? isDaySelectedList,
    String? goalStatement,
    String? actionStatement,
    String? oathStatement,
    bool? isActive,
    DateTime? startDate,
    String? resolutionId,
    List<UserDataEntity>? fanList,
  }) {
    return ResolutionModel(
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
