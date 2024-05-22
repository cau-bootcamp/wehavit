import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';

abstract class WehavitDatasource {
  EitherFuture<List<UserDataEntity>> getFriendModelList();

  EitherFuture<bool> registerFriend(
    String email,
  );

  EitherFuture<List<ConfirmPostEntity>> getGroupConfirmPostEntityListByDate(
    String groupId,
    DateTime selectedDate,
  );

  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityListByResolutionId(
    String resolutionId,
  );

  EitherFuture<ConfirmPostEntity> getConfirmPostOfTargetDateByResolutionGoalId(
    DateTime targetDate,
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

  EitherFuture<void> withdrawalFromGroup({
    required String groupId,
    required String targetUserId,
  });

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

  EitherFuture<int> getGroupSharedResolutionCount(String groupId);

  EitherFuture<int> getGroupSharedPostCount(String groupId);

  EitherFuture<GroupEntity> getGroupEntity({required String groupId});

  EitherFuture<bool> checkWhetherAlreadyAppliedToGroup({
    required String groupId,
  });

  EitherFuture<bool> checkWhetherAlreadyRegisteredToGroup({
    required String groupId,
  });

  EitherFuture<List<bool>> getTargetResolutionDoneListForWeek({
    required String resolutionId,
    required DateTime startMonday,
  });

  EitherFuture<List<GroupEntity>> getResolutionSharingTargetGroupList(
    String resolutionId,
  );

  EitherFuture<List<String>> getGroupAppliedUserIdList({
    required String groupId,
  });

  EitherFuture<double> getAchievementPercentageForGroupMember({
    required String groupId,
    required String userId,
  });

  EitherFuture<ResolutionEntity> getTargetResolutionEntity({
    required String targetUserId,
    required String targetResolutionId,
  });

  EitherFuture<void> incrementUserDataCounter({
    required UserIncrementalDataType type,
  });

  EitherFuture<void> updateAboutMe({required String newAboutMe});

  EitherFuture<void> applyForFriend({required String of});

  EitherFuture<List<EitherFuture<UserDataEntity>>> getAppliedUserList({
    required String forUser,
  });

  EitherFuture<void> handleFriendJoinRequest({
    required String targetUid,
    required bool isAccept,
  });

  EitherFuture<void> removeFriend({required String targetUid});
}
