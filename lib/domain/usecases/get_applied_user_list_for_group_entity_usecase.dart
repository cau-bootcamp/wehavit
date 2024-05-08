import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/group_repository.dart';

class GetAppliedUserListForGroupEntityUsecase {
  GetAppliedUserListForGroupEntityUsecase(this._groupRepository);

  final GroupRepository _groupRepository;

  EitherFuture<List<String>> call(GroupEntity groupEntity) async {
    return _groupRepository.getGroupAppliedUserIdList(
        groupId: groupEntity.groupId);
  }
}
