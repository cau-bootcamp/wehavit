import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetAppliedUserUidListForFriendUsecase {
  GetAppliedUserUidListForFriendUsecase(this._userModelRepository);

  final UserModelRepository _userModelRepository;

  EitherFuture<List<String>> call() async {
    return _userModelRepository
        .getMyUserId()
        .then((result) => result.fold((failure) => null, (myUid) => myUid))
        .then((uid) {
      if (uid != null) {
        return _userModelRepository.getAppliedUserIdList(forUser: uid);
      } else {
        return left(
          const Failure(
            'fail to load user id at GetAppliedUserListForFriendUsecase',
          ),
        );
      }
    });
  }
}
