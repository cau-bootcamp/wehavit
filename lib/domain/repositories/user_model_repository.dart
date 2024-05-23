import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';

abstract class UserModelRepository {
  EitherFuture<String> getMyUserId();

  EitherFuture<UserDataEntity> getUserDataEntityById(String targetUserId);

  EitherFuture<void> incrementUserDataCounter({
    required UserIncrementalDataType type,
  });

  EitherFuture<void> updateAmoutMe({
    required String newAboutMe,
  });

  EitherFuture<void> applyForFriend({required String of});

  EitherFuture<List<EitherFuture<UserDataEntity>>> getAppliedUserList({
    required String forUser,
  });

  EitherFuture<void> handleFriendJoinRequest({
    required String targetUid,
    required bool isAccept,
  });

  EitherFuture<void> removeFriend({required String targetUid});

  EitherFuture<List<EitherFuture<UserDataEntity>>> getUserDataListByNickname({
    required String nickname,
  });
}
