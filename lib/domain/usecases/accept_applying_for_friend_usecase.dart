import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class AcceptApplyingForFriendUsecase {
  AcceptApplyingForFriendUsecase(this._userModelRepository);

  final UserModelRepository _userModelRepository;

  EitherFuture<void> call({required String targetUid}) {
    return _userModelRepository.handleFriendJoinRequest(
      targetUid: targetUid,
      isAccept: true,
    );
  }
}
