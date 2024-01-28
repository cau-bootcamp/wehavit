import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class UploadResolutionUseCase {
  UploadResolutionUseCase(this._resolutionRepository);

  final ResolutionRepository _resolutionRepository;

  EitherFuture<bool> call({
    required String goalStatement,
    required String actionStatement,
    required List<UserDataEntity> shareFriendList,
    required List<GroupEntity> shareGroupList,
    required int actionPerWeek,
  }) async {
    ResolutionEntity entity = ResolutionEntity(
      goalStatement: goalStatement,
      actionStatement: actionStatement,
      startDate: DateTime.now(),
      isActive: true,
      shareFriendEntityList: shareFriendList,
      shareGroupEntityList: shareGroupList,
      actionPerWeek: actionPerWeek,
      resolutionId: '',
    );

    return _resolutionRepository.uploadResolutionEntity(entity);
  }
}
