import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/datasources/datasources.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/entities/group_weekly_report_entity/group_weekly_resport_entity.dart';
import 'package:wehavit/domain/repositories/group_repository.dart';

class GroupRepositoryImpl implements GroupRepository {
  GroupRepositoryImpl(this._wehavitDatasource);

  final WehavitDatasource _wehavitDatasource;

  @override
  EitherFuture<GroupEntity> createGroup({
    required String groupName,
    required String groupDescription,
    required String groupRule,
    required String groupManagerUid,
    required DateTime groupCreatedAt,
    required int groupColor,
  }) {
    return _wehavitDatasource.createGroup(
      groupName: groupName,
      groupDescription: groupDescription,
      groupRule: groupRule,
      groupManagerUid: groupManagerUid,
      groupColor: groupColor,
      groupCreatedAt: groupCreatedAt,
    );
  }

  @override
  EitherFuture<void> applyForJoiningGroup({required String groupId}) {
    return _wehavitDatasource.applyForJoiningGroup(groupId);
  }

  @override
  EitherFuture<void> acceptApplyingForGroup({
    required String groupId,
    required String targetUid,
  }) {
    return _wehavitDatasource.processApplyingForGroup(
      groupId: groupId,
      uid: targetUid,
      isAccepted: true,
    );
  }

  @override
  EitherFuture<void> rejectApplyingForGroup({
    required String groupId,
    required String targetUid,
  }) {
    return _wehavitDatasource.processApplyingForGroup(
      groupId: groupId,
      uid: targetUid,
      isAccepted: false,
    );
  }

  @override
  EitherFuture<void> withdrawalFromGroup({required String groupId}) {
    return _wehavitDatasource.withdrawalFromGroup(groupId: groupId);
  }

  @override
  EitherFuture<List<GroupEntity>> getGroupEntityList() async {
    try {
      final getResult = await _wehavitDatasource.getGroupEntityList();

      return getResult.fold(
        (failure) => left(failure),
        (entityList) {
          return Future(() => right(entityList));
        },
      );
    } on Exception catch (e) {
      return Future(() => left(Failure(e.toString())));
    }
  }

  @override
  EitherFuture<void> uploadGroupAnnouncementEntity(
    GroupAnnouncementEntity entity,
  ) {
    return _wehavitDatasource.uploadGroupAnnouncement(entity);
  }

  @override
  EitherFuture<List<GroupAnnouncementEntity>> getGroupAnnouncementEntityList(
    String groupId,
  ) {
    return _wehavitDatasource.getGroupAnnouncementEntityList(groupId);
  }

  @override
  EitherFuture<void> readGroupAnnouncement(GroupAnnouncementEntity entity) {
    return _wehavitDatasource.readGroupAnnouncement(entity);
  }

  @override
  EitherFuture<GroupWeeklyReportEntity> getGroupWeeklyReport(
    String groupId,
  ) {
    return _wehavitDatasource.getGroupWeeklyReport(groupId);
  }

  @override
  EitherFuture<(EitherFuture<int>, EitherFuture<int>)>
      getGroupListViewCellModelData(String groupId) {
    final sharedResolutionsCount =
        _wehavitDatasource.getGroupSharedResolutionCount(groupId);
    final sharedPostsCount =
        _wehavitDatasource.getGroupSharedPostCount(groupId);

    return Future(() => right((sharedResolutionsCount, sharedPostsCount)));
  }

  @override
  EitherFuture<GroupEntity> getGroupEntity({required String groupId}) {
    return _wehavitDatasource.getGroupEntity(groupId: groupId);
  }
}
