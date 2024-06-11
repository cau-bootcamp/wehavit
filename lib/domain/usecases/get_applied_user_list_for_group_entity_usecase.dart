import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetAppliedUserListForGroupEntityUsecase {
  GetAppliedUserListForGroupEntityUsecase(
    this._userModelRepository,
    this._groupRepository,
  );

  final UserModelRepository _userModelRepository;
  final GroupRepository _groupRepository;

  EitherFuture<List<String>> call(GroupEntity groupEntity) async {
    final myUid = await _userModelRepository
        .getMyUserId()
        .then((result) => result.fold((failure) => null, (uid) => uid));
    if (myUid == null) {
      return Future(() => left(const Failure('fail to get my uid')));
    }

    if (groupEntity.groupManagerUid.compareTo(myUid) == 0) {
      return _groupRepository.getGroupAppliedUserIdList(
        groupId: groupEntity.groupId,
      );
    } else {
      return Future(
        () => left(const Failure('current user is not manager of this group')),
      );
    }
  }
}
