import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/group_repository.dart';

class RejectApplyingForJoiningGroupUsecase
    extends FutureUseCase<void, (String, String)> {
  RejectApplyingForJoiningGroupUsecase(this._groupRepository);

  final GroupRepository _groupRepository;

  @override
  EitherFuture<void> call((String, String) params) {
    return _groupRepository.rejectApplyingForGroup(
      groupId: params.$1,
      targetUid: params.$2,
    );
  }
}
