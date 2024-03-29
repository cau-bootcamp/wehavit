import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
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
    try {
      final getResult =
          await _wehavitDatasource.getActiveResolutionEntityList(userId);

      return getResult.fold(
        (failure) => left(failure),
        (entityList) async {
          return Future(() => right(entityList));
        },
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
      return Future(() => left(Failure(e.toString())));
    }
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
  EitherFuture<int> getResolutionDoneCountForThisWeek(String resolutionId) {
    return _wehavitDatasource.getTargetResolutionDoneCountForThisWeek(
      resolutionId: resolutionId,
    );
  }

  @override
  EitherFuture<List<GroupEntity>> getResolutionSharingTargetGroupList(
    String resolutionId,
  ) {
    return _wehavitDatasource.getResolutionSharingTargetGroupList(resolutionId);
  }
}
