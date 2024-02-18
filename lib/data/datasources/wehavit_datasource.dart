import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/entities/group_announcement_entity/group_announcement_entity.dart';

abstract class WehavitDatasource {
  EitherFuture<List<UserDataEntity>> getFriendModelList();

  EitherFuture<bool> registerFriend(
    String email,
  );

  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityListByDate(
    DateTime selectedDate,
  );

  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityListByResolutionId(
    String resolutionId,
  );

  EitherFuture<ConfirmPostEntity> getConfirmPostOfTodayByResolutionGoalId(
    String resolutionId,
  );

  EitherFuture<bool> uploadConfirmPost(ConfirmPostEntity confirmPost);

  EitherFuture<bool> updateConfirmPost(ConfirmPostEntity confirmPost);

  EitherFuture<bool> deleteConfirmPost(ConfirmPostEntity confirmPost);

  EitherFuture<bool> sendReactionToTargetConfirmPost(
    ConfirmPostEntity targetEntity,
    ReactionEntity reactionEntity,
  );

  EitherFuture<List<ReactionEntity>> getUnreadReactionsAndDelete();
  EitherFuture<List<ReactionEntity>> getReactionsFromConfirmPost(
    ConfirmPostEntity entity,
  );

  EitherFuture<List<ResolutionEntity>> getActiveResolutionEntityList(
    String userId,
  );

  EitherFuture<bool> uploadResolutionEntity(ResolutionEntity entity);

  EitherFuture<UserDataEntity> fetchUserDataEntityByUserId(String targetUserId);

  String getMyUserId();

  EitherFuture<String> uploadQuickShotFromLocalUrlToConfirmPost({
    required String localPhotoUrl,
    required ConfirmPostEntity entity,
  });

  EitherFuture<String> uploadConfirmPostImageFromLocalUrl(String localFileUrl);

  EitherFuture<GroupEntity> createGroup({
    required String groupName,
    required String groupDescription,
    required String groupRule,
    required String groupManagerUid,
    required DateTime groupCreatedAt,
    required int groupColor,
  });

  EitherFuture<void> applyForJoiningGroup(String groupId);

  EitherFuture<void> processApplyingForGroup({
    required String groupId,
    required String uid,
    required bool isAccepted,
  });

  EitherFuture<void> withdrawalFromGroup({required String groupId});

  EitherFuture<List<GroupEntity>> getGroupEntityList();

  EitherFuture<void> changeGroupStateOfResolution({
    required String repositoryId,
    required String groupId,
    required bool toShareState,
  });

  EitherFuture<void> uploadGroupAnnouncement(GroupAnnouncementEntity entity);

  EitherFuture<List<GroupAnnouncementEntity>> getGroupAnnouncementEntityList(
    String groupId,
  );

  EitherFuture<void> readGroupAnnouncement(GroupAnnouncementEntity entity);

  EitherFuture<GroupWeeklyReportEntity> getGroupWeeklyReport(
    String groupId,
  );
}
