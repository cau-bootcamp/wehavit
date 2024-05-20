import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/data/datasources/datasources.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class ResolutionRepositoryImpl implements ResolutionRepository {
  ResolutionRepositoryImpl(this._wehavitDatasource);

  final WehavitDatasource _wehavitDatasource;
  @override
  EitherFuture<List<ResolutionEntity>> getActiveResolutionEntityList(
    String userId,
  ) async {
    return _wehavitDatasource.getActiveResolutionEntityList(userId);
  }

  @override
  EitherFuture<bool> uploadResolutionEntity(
    ResolutionEntity entity,
  ) async {
    return _wehavitDatasource.uploadResolutionEntity(entity);
  }

  @override
  EitherFuture<void> shareResolutionToGroup(
    String repositoryId,
    String groupId,
  ) {
    return _wehavitDatasource.changeGroupStateOfResolution(
      repositoryId: repositoryId,
      groupId: groupId,
      toShareState: true,
    );
  }

  @override
  EitherFuture<void> unshareResolutionToGroup(
    String repositoryId,
    String groupId,
  ) {
    return _wehavitDatasource.changeGroupStateOfResolution(
      repositoryId: repositoryId,
      groupId: groupId,
      toShareState: false,
    );
  }

  @override
  EitherFuture<List<bool>> getResolutionDoneListForWeek({
    required String resolutionId,
    required DateTime startMonday,
  }) {
    return _wehavitDatasource.getTargetResolutionDoneListForWeek(
      resolutionId: resolutionId,
      startMonday: startMonday,
    );
  }

  @override
  EitherFuture<List<GroupEntity>> getResolutionSharingTargetGroupList(
    String resolutionId,
  ) {
    return _wehavitDatasource.getResolutionSharingTargetGroupList(resolutionId);
  }

  @override
  EitherFuture<ResolutionEntity> getTargetResolutionEntity({
    required String targetUserId,
    required String targetResolutionId,
  }) {
    return _wehavitDatasource.getTargetResolutionEntity(
      targetUserId: targetUserId,
      targetResolutionId: targetResolutionId,
    );
  }
}
