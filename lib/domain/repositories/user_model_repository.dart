import 'dart:io';

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

  EitherFuture<List<String>> getAppliedUserIdList({
    required String forUser,
  });

  EitherFuture<void> handleFriendJoinRequest({
    required String targetUid,
    required bool isAccept,
  });

  EitherFuture<void> removeFriend({required String targetUid});

  EitherFuture<List<String>> getUidListByHandle({
    required String handle,
  });

  EitherFuture<List<EitherFuture<UserDataEntity>>> getUserDataListByNickname({
    required String nickname,
  });

  EitherFuture<void> registerUserData({
    required String uid,
    required String name,
    required File userImageFile,
    required String aboutMe,
    required String handle,
  });

  EitherFuture<void> removeCurrentUserData();

  EitherFuture<void> updateFCMToken({required bool delete});

  EitherFuture<String> getUserFCMMessageToken({required String uid});

  EitherFuture<List<QuickshotPresetItemEntity>> getQuickshotPresets();

  EitherFuture<void> uploadQuickshotPreset(
    String quickshotImageUrl,
  );

  EitherFuture<void> removeQuickshotPreset(
    QuickshotPresetItemEntity quickshotPresetItemEntity,
  );
}
