import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/repositories/resolution_repository.dart';

class GetSharedResolutionListToGroupUsecase {
  GetSharedResolutionListToGroupUsecase(this._resolutionRepository);

  final ResolutionRepository _resolutionRepository;

  EitherFuture<List<String>> call(
    String userId,
    String groupId,
  ) async {
    return _resolutionRepository.getResolutionIdListSharedToGroup(
      fromUserId: userId,
      toGroupId: groupId,
    );
  }
}
