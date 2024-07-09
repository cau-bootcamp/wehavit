import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';

abstract class ResolutionRepository {
  EitherFuture<List<ResolutionEntity>> getActiveResolutionEntityList(
    String userId,
  );

  EitherFuture<String> uploadResolutionEntity(ResolutionEntity model);

  EitherFuture<void> shareResolutionToGroup(
    String resolutionId,
    String groupId,
  );

  EitherFuture<void> unshareResolutionToGroup(
    String resolutionId,
    String groupId,
  );

  EitherFuture<void> shareResolutionToFriend(
    String resolutionId,
    String friendId,
  );

  EitherFuture<void> unshareResolutionToFriend(
    String resolutionId,
    String friendId,
  );

  EitherFuture<List<bool>> getResolutionDoneListForWeek({
    required String resolutionId,
    required DateTime startMonday,
  });

  EitherFuture<List<GroupEntity>> getResolutionSharingTargetGroupList(
    String resolutionId,
  );

  EitherFuture<List<String>> getResolutionIdListSharedToMe({
    required String from,
  });

  EitherFuture<ResolutionEntity> getTargetResolutionEntity({
    required String targetUserId,
    required String targetResolutionId,
  });

  EitherFuture<void> updateResolutionEntity({
    required String targetResolutionId,
    required ResolutionEntity newEntity,
  });

  EitherFuture<void> incrementWrittenPostCount({
    required String targetResolutionId,
  });

  EitherFuture<void> incrementReceivedReactionCount({
    required String targetResolutionId,
  });

  EitherFuture<void> updateWeekSuccessCount({
    required String targetResolutionId,
  });
}
