import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';

abstract class GroupRepository {
  // return groupId
  EitherFuture<GroupEntity> createGroup({
    required String groupName,
    required String groupDescription,
    required String groupRule,
    required String groupManagerUid,
    required DateTime groupCreatedAt,
    required int groupColor,
  });

  EitherFuture<void> applyForJoiningGroup({required String groupId});

  EitherFuture<void> acceptApplyingForGroup({
    required String groupId,
    required String targetUid,
  });

  EitherFuture<void> rejectApplyingForGroup({
    required String groupId,
    required String targetUid,
  });

  EitherFuture<void> withdrawalFromGroup({required String groupId});

  EitherFuture<GroupEntity> getGroupEntity({required String groupId});

  EitherFuture<List<GroupEntity>> getGroupEntityList();

  EitherFuture<void> uploadGroupAnnouncementEntity(
    GroupAnnouncementEntity entity,
  );

  EitherFuture<List<GroupAnnouncementEntity>> getGroupAnnouncementEntityList(
    String groupId,
  );

  EitherFuture<void> readGroupAnnouncement(GroupAnnouncementEntity entity);

  EitherFuture<GroupWeeklyReportEntity> getGroupWeeklyReport(
    String groupId,
  );

  // 현재 그룹 내에 공유중인 목표 수, 지금까지 그룹 내 인증글 수를 반환
  EitherFuture<(EitherFuture<int>, EitherFuture<int>)>
      getGroupListViewCellModelData(String groupId);
}
