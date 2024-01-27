import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/group_repository.dart';

class AcceptApplyingForJoiningGroupUsecase
    extends FutureUseCase<void, (String, String)> {
  AcceptApplyingForJoiningGroupUsecase(this._groupRepository);

  final GroupRepository _groupRepository;

  @override
  EitherFuture<void> call((String, String) params) {
    // return _groupRepository.applyForJoiningGroup(groupId: params);
    return _groupRepository.acceptApplyingForGroup(
      groupId: params.$1,
      targetUid: params.$2,
    );
  }
}
