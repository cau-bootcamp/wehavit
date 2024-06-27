import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class ApplyForUserFriendUsecase {
  ApplyForUserFriendUsecase(this._userModelRepository);

  final UserModelRepository _userModelRepository;

  EitherFuture<void> call({required String targetUserId}) {
    return _userModelRepository.applyForFriend(of: targetUserId);
  }
}
