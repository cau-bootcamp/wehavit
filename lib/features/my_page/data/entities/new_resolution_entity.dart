import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/features/my_page/domain/models/add_resolution_model.dart';

class ResolutionToUploadEntity {
  ResolutionToUploadEntity(AddResolutionModel model) {
    goal = model.goalStatement;
    action = model.actionStatement;
    startDate = DateTime.now();
    isActive = true;

    period = _periodToInt(model.isDaySelectedList);
  }

  late String goal;
  late String action;
  late int period;
  late DateTime startDate;
  late bool isActive;

  int _periodToInt(List<bool> periodList) {
    var result = 0;
    for (var element in periodList) {
      result += element ? 1 : 0;
      result << 2;
    }
    return result;
  }

  Map<String, dynamic> toFirebaseDocument() {
    final Map<String, dynamic> doc = {};

    doc[FirebaseFieldName.resolutionGoalStatement] = goal;
    doc[FirebaseFieldName.resolutionActionStatement] = action;
    doc[FirebaseFieldName.resolutionPeriod] = period;
    doc[FirebaseFieldName.resolutionStartDate] = startDate;
    doc[FirebaseFieldName.resolutionIsActive] = isActive;

    return doc;
  }
}
