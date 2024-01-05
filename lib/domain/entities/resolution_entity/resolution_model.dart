import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';

class ResolutionModel {
  ResolutionModel({
    required this.resolutionId,
    required this.isActive,
    required this.goalStatement,
    required this.actionStatement,
    required this.oathStatement,
    required this.isDaySelectedList,
    required this.startDate,
    required this.fanList,
  });

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

  String resolutionId;
  String goalStatement;
  String actionStatement;
  String oathStatement;
  List<bool> isDaySelectedList;
  DateTime startDate;
  bool isActive;
  List<String> fanList = [];

  ResolutionModel copyWith({
    List<bool>? isDaySelectedList,
    String? goalStatement,
    String? actionStatement,
    String? oathStatement,
    bool? isActive,
    DateTime? startDate,
    String? resolutionId,
    List<String>? fanList,
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
