import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/notification_repository.dart';

enum NotificationType {
  uploadPost,
  sendReaction,
}

class SendNotificationToTargetUserUsecase {
  SendNotificationToTargetUserUsecase(
    this._notificationRepository,
  );

  final NotificationRepository _notificationRepository;

  static String messageTitleTemplate = 'WeHavit';
  static String messageContentTemplate = 'NAME님이 응원을 보내줬어요!';

  EitherFuture<void> call({
    required UserDataEntity? myUserEntity,
    required UserDataEntity targetUserEntity,
    NotificationType type = NotificationType.sendReaction,
  }) async {
    if (myUserEntity == null) {
      return left(
        const Failure(
          'cannot get user entity from SendNotificationToTargetUserUsecase',
        ),
      );
    }

    // 스스로에게는 메시지를 보내지 않는다.
    if (myUserEntity.userId == targetUserEntity.userId) {
      return left(const Failure('나에게는 메시지를 보낼 수 없어요'));
    }
    List<String> sharingUserTokenList = [targetUserEntity.messageToken];

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
