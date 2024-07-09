import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class UploadResolutionUseCase {
  UploadResolutionUseCase(
    this._resolutionRepository,
    this._userModelRepository,
  );

  final ResolutionRepository _resolutionRepository;
  final UserModelRepository _userModelRepository;

  EitherFuture<ResolutionEntity?> call({
    required String resolutionName,
    required String goalStatement,
    required String actionStatement,
    required List<UserDataEntity> shareFriendList,
    required List<GroupEntity> shareGroupList,
    required int actionPerWeek,
    required int colorIndex,
    required int iconIndex,
  }) async {
    ResolutionEntity entity = ResolutionEntity(
      resolutionName: resolutionName,
      goalStatement: goalStatement,
      actionStatement: actionStatement,
      startDate: DateTime.now(),
      isActive: true,
      shareFriendEntityList: shareFriendList,
      shareGroupEntityList: shareGroupList,
      actionPerWeek: actionPerWeek,
      colorIndex: colorIndex,
      iconIndex: iconIndex,
      resolutionId: '',
      writtenPostCount: 0,
      receivedReactionCount: 0,
      successWeekList: [],
    );

    return _resolutionRepository.uploadResolutionEntity(entity).then(
          (result) => result.fold(
              (failure) =>
                  left(const Failure("can't get resolution entity id")),
              (resolutionId) async {
            await _userModelRepository.incrementUserDataCounter(
              type: UserIncrementalDataType.goal,
            );
            return right(entity.copyWith(resolutionId: resolutionId));
          }),
        );
  }
}
