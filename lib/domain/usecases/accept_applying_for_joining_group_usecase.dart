import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/group_repository.dart';

class AcceptApplyingForJoiningGroupUsecase {
  AcceptApplyingForJoiningGroupUsecase(this._groupRepository);

  final GroupRepository _groupRepository;

  EitherFuture<void> call({required String groupId, required String userId}) {
    return _groupRepository.acceptApplyingForGroup(
      groupId: groupId,
      targetUid: userId,
    );
  }
}
