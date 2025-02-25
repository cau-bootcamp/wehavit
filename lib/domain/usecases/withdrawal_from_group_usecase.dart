import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/group_repository.dart';

class WithdrawalTargetUserFromGroupUsecase {
  WithdrawalTargetUserFromGroupUsecase(this._groupRepository);

  final GroupRepository _groupRepository;

  EitherFuture<void> call({required String groupId, required String targetUserId}) {
    return _groupRepository.withdrawalTargetUserFromGroup(
      groupId: groupId,
      targetUserId: targetUserId,
    );
  }
}
