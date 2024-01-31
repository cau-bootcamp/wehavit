import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetGroupWeeklyReportUsecase {
  GetGroupWeeklyReportUsecase(
    this._groupRepository,
  );

  final GroupRepository _groupRepository;

  EitherFuture<GroupWeeklyReportEntity> call({
    required String groupId,
  }) async {
    return _groupRepository.getGroupWeeklyReport(groupId);
  }
}
