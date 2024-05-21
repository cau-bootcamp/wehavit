import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';

abstract class UserModelRepository {
  EitherFuture<String> getMyUserId();

  EitherFuture<UserDataEntity> fetchUserDataEntityFromId(String targetUserId);

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
}
