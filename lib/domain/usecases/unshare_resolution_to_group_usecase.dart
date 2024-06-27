import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class UnshareResolutionToGroupUsecase {
  UnshareResolutionToGroupUsecase(this._resolutionRepository);

  final ResolutionRepository _resolutionRepository;

  EitherFuture<void> call({
    required String resolutionId,
    required String groupId,
  }) async {
    return await _resolutionRepository.unshareResolutionToGroup(
      resolutionId,
      groupId,
    );
  }
}
