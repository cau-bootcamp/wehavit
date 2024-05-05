import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/group_repository.dart';

class RejectApplyingForJoiningGroupUsecase {
  RejectApplyingForJoiningGroupUsecase(this._groupRepository);

  final GroupRepository _groupRepository;

  @override
  EitherFuture<void> call({required String groupId, required String userId}) {
    return _groupRepository.rejectApplyingForGroup(
      groupId: groupId,
      targetUid: userId,
    );
  }
}
