import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';

abstract class GroupRepository {
  // return groupId
  EitherFuture<GroupEntity> createGroup({
    required String groupName,
    required String groupDescription,
    required String groupRule,
    required String groupManagerUid,
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
}
