import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/group_repository.dart';
import 'package:wehavit/domain/repositories/notification_repository.dart';
import 'package:wehavit/domain/repositories/user_model_repository.dart';

class SendNotificationToSharedUsersUsecase {
  SendNotificationToSharedUsersUsecase(
    this._groupRepository,
    this._userModelRepository,
    this._notificationRepository,
  );

  final GroupRepository _groupRepository;
  final UserModelRepository _userModelRepository;
  final NotificationRepository _notificationRepository;

  EitherFuture<void> call({
    required ResolutionEntity entity,
  }) async {
    List<String> sharingUserTokenList = [];

    final groupEntityList = entity.shareGroupEntityList ?? [];
    final friendEntityList = entity.shareFriendEntityList ?? [];

    await Future.forEach(groupEntityList, (GroupEntity groupEntity) async {
      await Future.forEach(groupEntity.groupMemberUidList, (String uid) async {
        final token =
            await _userModelRepository.getUserFCMMessageToken(uid: uid).then(
                  (result) => result.fold(
                    (failure) => null,
                    (token) => token,
                  ),
                );

        if (token != null) {
          sharingUserTokenList.add(token);
        }
      });
    });

    await Future.forEach(friendEntityList, (UserDataEntity userEntity) async {
      if (userEntity.messageToken != null) {
        sharingUserTokenList.add(userEntity.messageToken!);
      }
    });

    sharingUserTokenList = sharingUserTokenList.toSet().toList();

    // TODO
    await _notificationRepository.sendNotification(
      title: "hello",
      content: "hi there",
      targetTokenList: sharingUserTokenList,
    );

    return Future(() => right(null));
  }
}
