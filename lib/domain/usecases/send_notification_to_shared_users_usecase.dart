import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/notification_repository.dart';
import 'package:wehavit/domain/repositories/user_model_repository.dart';

class SendNotificationToSharedUsersUsecase {
  SendNotificationToSharedUsersUsecase(
    this._userModelRepository,
    this._notificationRepository,
  );

  final UserModelRepository _userModelRepository;
  final NotificationRepository _notificationRepository;

  static String messageTitleTemplate = 'WeHavit';
  static String messageContentTemplate = 'NAME님의 새로운 인증글이 여러분의 응원을 기다리고 있어요!';

  EitherFuture<void> call({
    required UserDataEntity? myUserEntity,
    required ResolutionEntity resolutionEntity,
  }) async {
    if (myUserEntity == null) {
      return left(
        const Failure(
          'cannot get user entity from SendNotificationToSharedUsersUsecase',
        ),
      );
    }

    List<String> sharingUserTokenList = [];

    final groupEntityList = resolutionEntity.shareGroupEntityList;
    final friendEntityList = resolutionEntity.shareFriendEntityList;

    await Future.forEach(groupEntityList, (GroupEntity groupEntity) async {
      await Future.forEach(groupEntity.groupMemberUidList, (String uid) async {
        // 스스로에게는 메시지를 보내지 않는다.
        if (myUserEntity.userId == uid) {
          return;
        }

        final token = await _userModelRepository.getUserFCMMessageToken(uid: uid).then(
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
      sharingUserTokenList.add(userEntity.messageToken);
    });

    sharingUserTokenList = sharingUserTokenList.toSet().toList();

    await _notificationRepository.sendNotification(
      title: messageTitleTemplate,
      content: messageContentTemplate.replaceFirst(
        'NAME',
        myUserEntity.userName,
      ),
      targetTokenList: sharingUserTokenList,
    );

    return Future(() => right(null));
  }
}
