import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class RejectApplyingForFriendUsecase {
  RejectApplyingForFriendUsecase(this._userModelRepository);

  final UserModelRepository _userModelRepository;

  EitherFuture<void> call({required String targetUid}) {
    return _userModelRepository.handleFriendJoinRequest(
      targetUid: targetUid,
      isAccept: false,
    );
  }
}
