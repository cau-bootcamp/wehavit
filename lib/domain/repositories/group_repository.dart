import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/group_entity/group_entity.dart';

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
}
