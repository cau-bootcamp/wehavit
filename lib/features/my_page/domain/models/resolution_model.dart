import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';

class ResolutionModel {
  ResolutionModel({
    required this.isActive,
    required this.goalStatement,
    required this.actionStatement,
    required this.oathStatement,
    required this.isDaySelectedList,
    required this.startDate,
  });

  ResolutionModel.fromMapData(Map<String, dynamic> data)
      : goalStatement =
            data[FirebaseResolutionFieldName.resolutionGoalStatement],
        actionStatement =
            data[FirebaseResolutionFieldName.resolutionActionStatement],
        isDaySelectedList = data[FirebaseResolutionFieldName.resolutionPeriod],
        startDate =
            (data[FirebaseResolutionFieldName.resolutionStartDate] as Timestamp)
                .toDate(),
        isActive = data[FirebaseResolutionFieldName.resolutionIsActive],
        oathStatement = data[FirebaseResolutionFieldName];

  String goalStatement;
  String actionStatement;
  String oathStatement;
  List<bool> isDaySelectedList;
  DateTime startDate;
  bool isActive;

  ResolutionModel copyWith({
    List<bool>? isDaySelectedList,
    String? goalStatement,
    String? actionStatement,
    String? oathStatement,
    bool? isActive,
    DateTime? startDate,
  }) {
    return ResolutionModel(
      goalStatement: goalStatement ?? this.goalStatement,
      actionStatement: actionStatement ?? this.actionStatement,
      oathStatement: oathStatement ?? this.oathStatement,
      isDaySelectedList: isDaySelectedList ?? this.isDaySelectedList,
      isActive: isActive ?? this.isActive,
      startDate: startDate ?? this.startDate,
    );
  }
}
