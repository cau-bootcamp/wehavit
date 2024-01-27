import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/group_entity/group_entity.dart';
import 'package:wehavit/domain/repositories/group_repository.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class CreateGroupUsecase
    implements FutureUseCase<void, (String, String, String)> {
  CreateGroupUsecase(this._groupRepository, this._userModelRepository);

  final GroupRepository _groupRepository;
  final UserModelRepository _userModelRepository;

  @override
  EitherFuture<GroupEntity> call(
    params,
  ) async {
    final fetchUid = (await _userModelRepository.getMyUserId()).fold(
      (l) => null,
      (uid) => uid,
    );

    if (fetchUid == null) {
      return Future(() => left(const Failure('fail to get my uid')));
    }

    final groupEntity = (await _groupRepository.createGroup(
      groupName: params.$1,
      groupDescription: params.$2,
      groupRule: params.$3,
      groupManagerUid: fetchUid,
    ))
        .fold(
      (l) => null,
      (groupEntity) => groupEntity,
    );

    if (groupEntity == null) {
      return Future(() => left(const Failure('fail to create group')));
    }

    return Future(() => right(groupEntity));
  }
}
