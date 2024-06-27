import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class CheckWhetherAlreadyAppliedToGroupUsecase {
  CheckWhetherAlreadyAppliedToGroupUsecase(this._groupRepository);

  final GroupRepository _groupRepository;

  EitherFuture<bool> call(String groupId) {
    return _groupRepository.checkWhetherAlreadyAppliedToGroup(groupId: groupId);
  }
}
