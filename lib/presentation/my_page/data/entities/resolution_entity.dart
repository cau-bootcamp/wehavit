import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/domain/entities/user_data_entity/friend_model.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_model.dart';

class ResolutionEntity {
  ResolutionEntity.fromFirebaseDocument(
    Map<String, dynamic> data,
    this.resolutionId,
  )   : goal = data[FirebaseResolutionFieldName.resolutionGoalStatement],
        action = data[FirebaseResolutionFieldName.resolutionActionStatement],
        period = data[FirebaseResolutionFieldName.resolutionPeriod],
        startDate =
            (data[FirebaseResolutionFieldName.resolutionStartDate] as Timestamp)
                .toDate(),
        isActive = data[FirebaseResolutionFieldName.resolutionIsActive],
        fanList = (data[FirebaseResolutionFieldName.resolutionFanList] ?? [])
            .cast<String>()
            .toList();

  ResolutionEntity.fromResolutionModel(ResolutionModel model) {
    goal = model.goalStatement!;
    action = model.actionStatement!;
    startDate = DateTime.now();
    isActive = true;
    period = model.isDaySelectedList!.toIntPeriod();
    resolutionId = model.resolutionId!;
    fanList = model.fanList!;
  }

  late String goal;
  late String action;
  late int period;
  late DateTime startDate;
  late bool isActive;
  late String resolutionId;
  late List<UserDataEntity> fanList;
}

extension ResolutionEntityConvertFunctions on ResolutionEntity {
  /// Firebase Document로 Entity를 변환
  Map<String, dynamic> toFirebaseDocument() {
    final Map<String, dynamic> doc = {};

    doc[FirebaseResolutionFieldName.resolutionGoalStatement] = goal;
    doc[FirebaseResolutionFieldName.resolutionActionStatement] = action;
    doc[FirebaseResolutionFieldName.resolutionPeriod] = period;
    doc[FirebaseResolutionFieldName.resolutionStartDate] = startDate;
    doc[FirebaseResolutionFieldName.resolutionIsActive] = isActive;
    doc[FirebaseResolutionFieldName.resolutionFanList] = fanList;

    return doc;
  }

  ResolutionModel toResolutionModel() {
    final model = ResolutionModel(
      isActive: isActive,
      goalStatement: goal,
      actionStatement: action,
      isDaySelectedList: period.toBoolListPeriod(),
      startDate: startDate,
      oathStatement: '',
      resolutionId: resolutionId,
      fanList: fanList,
    );
    return model;
  }
}

extension ConvertBoolListToInt on List {
  /// List 타입으로 되어있는 요일 별 실천 일정을 2진수로 대응되는 int 타입으로 변경
  int toIntPeriod() {
    var result = 0;
    map((isChecked) {
      result << 1;
      result += isChecked ? 1 : 0;
    });
    return result;
  }
}

extension ConvertIntToBoolList on int {
  /// List 타입으로 되어있는 요일 별 실천 일정을 2진수로 대응되는 int 타입으로 변경
  List<bool> toBoolListPeriod() {
    final result = List<bool>.filled(7, false);
    for (int idx = 0; idx < 7; idx++) {
      result[7 - idx - 1] = (this & 1 == 1 ? true : false);
      this >> 1;
    }
    return result;
  }
}
