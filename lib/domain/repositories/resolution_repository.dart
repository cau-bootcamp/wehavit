import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';

abstract class ResolutionRepository {
  EitherFuture<List<ResolutionEntity>> getActiveResolutionEntityList(
    String userId,
  );

  EitherFuture<bool> uploadResolutionEntity(ResolutionEntity model);

  EitherFuture<void> shareResolutionToGroup(String $1, String $2);

  EitherFuture<void> unshareResolutionToGroup(String $1, String $2);

  EitherFuture<List<bool>> getResolutionDoneListForWeek({
    required String resolutionId,
    required DateTime startMonday,
  });

  EitherFuture<List<GroupEntity>> getResolutionSharingTargetGroupList(
    String resolutionId,
  );

  EitherFuture<ResolutionEntity> getTargetResolutionEntity({
    required String targetUserId,
    required String targetResolutionId,
  });
}
