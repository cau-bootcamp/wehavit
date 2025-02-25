import 'package:wehavit/domain/entities/entities.dart';

class GroupWeeklyReportEntity {
  GroupWeeklyReportEntity({
    required this.groupId,
    required this.groupWeeklyReportCellList,
  });

  String groupId;
  List<GroupWeeklyReportCell> groupWeeklyReportCellList;
}

class GroupWeeklyReportCell {
  GroupWeeklyReportCell(
    this.memberEntity,
    this.memberResolutionList,
    this.memberSuccessResolutionMap,
    this.doneResolutionIdListForEachDay,
  );

  UserDataEntity memberEntity;
  List<ResolutionEntity> memberResolutionList;
  Map<String, bool> memberSuccessResolutionMap;
  List<List<String>> doneResolutionIdListForEachDay;
}
