import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/datasources/datasources.dart';
import 'package:wehavit/domain/entities/entities.dart';
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
  EitherFuture<void> withdrawalTargetUserFromGroup({
    required String groupId,
    required String targetUserId,
  }) {
    return _wehavitDatasource.withdrawalFromGroup(
      groupId: groupId,
      targetUserId: targetUserId,
    );
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
  EitherFuture<(int, int)> getGroupListViewCellModelData(String groupId) async {
    final sharedResolutionsCount = await _wehavitDatasource.getGroupSharedResolutionCount(groupId);
    final sharedPostsCount = await _wehavitDatasource.getGroupSharedPostCount(groupId);

    if (sharedResolutionsCount.isLeft()) return Future(() => left(const Failure('공유중인 목표 수를 가져오는데에 실패했습니다')));
    if (sharedPostsCount.isLeft()) return Future(() => left(const Failure('공유중인 인증글 수를 가져오는데에 실패했습니다')));

    final resolutionCount = sharedResolutionsCount.fold((_) => 0, (value) => value);
    final postCount = sharedPostsCount.fold((_) => 0, (value) => value);

    return Future(() => right((resolutionCount, postCount)));
  }

  @override
  EitherFuture<GroupEntity> getGroupEntityById({required String groupId}) {
    return _wehavitDatasource.getGroupEntityById(groupId: groupId);
  }

  @override
  EitherFuture<bool> checkWhetherAlreadyAppliedToGroup({
    required String groupId,
  }) {
    return _wehavitDatasource.checkWhetherAlreadyAppliedToGroup(
      groupId: groupId,
    );
  }

  @override
  EitherFuture<bool> checkWhetherAlreadyRegisteredToGroup({
    required String groupId,
  }) {
    return _wehavitDatasource.checkWhetherAlreadyRegisteredToGroup(
      groupId: groupId,
    );
  }

  @override
  EitherFuture<List<String>> getGroupAppliedUserIdList({
    required String groupId,
  }) {
    return _wehavitDatasource.getGroupAppliedUserIdList(groupId: groupId);
  }

  @override
  EitherFuture<double> getAchievementPercentageForGroupMember({
    required String groupId,
    required String userId,
  }) {
    return _wehavitDatasource.getAchievementPercentageForGroupMember(
      groupId: groupId,
      userId: userId,
    );
  }

  @override
  EitherFuture<GroupEntity> getGroupEntityByName({
    required String groupName,
  }) {
    return _wehavitDatasource.getGroupEntityByName(groupName: groupName);
  }

  @override
  EitherFuture<List<GroupEntity>> getGroupEntityListByGroupName({
    required String keyword,
  }) {
    return _wehavitDatasource.getGroupEntityListByGroupName(keyword: keyword);
  }

  @override
  EitherFuture<(int, int)> getGroupListViewFriendCellModelData(
    List<String> sharedResolutionIdList,
  ) async {
    final sharedPostsCount = await _wehavitDatasource.getFriendSharedPostCount(sharedResolutionIdList);

    print(sharedPostsCount);

    if (sharedPostsCount.isLeft()) return Future(() => left(const Failure('공유중인 인증글 수를 가져오는데에 실패했습니다')));
    final postCount = sharedPostsCount.fold((_) => 0, (value) => value);

    return Future(() => right((sharedResolutionIdList.length, postCount)));
  }
}
