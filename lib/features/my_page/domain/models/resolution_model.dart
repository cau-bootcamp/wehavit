import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';

class ResolutionModel {
  ResolutionModel({
    required this.goal,
    required this.action,
    required this.period,
    required this.startDate,
  });

  ResolutionModel.fromMapData(Map<String, dynamic> data)
      : goal = data[FirebaseFieldName.resolutionGoalStatement],
        action = data[FirebaseFieldName.resolutionActionStatement],
        period = data[FirebaseFieldName.resolutionPeriod],
        startDate =
            (data[FirebaseFieldName.resolutionStartDate] as Timestamp).toDate();

  bool isActive = true;

  String goal;
  String action;
  int period;
  DateTime startDate;

  // List<> confirmationList;
}
