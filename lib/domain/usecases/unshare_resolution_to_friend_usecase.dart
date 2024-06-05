import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class UnshareResolutionToFriendUsecase {
  UnshareResolutionToFriendUsecase(this._resolutionRepository);

  final ResolutionRepository _resolutionRepository;

  EitherFuture<void> call({
    required String resolutionId,
    required String friendId,
  }) async {
    return await _resolutionRepository.unshareResolutionToGroup(
      resolutionId,
      friendId,
    );
  }
}
