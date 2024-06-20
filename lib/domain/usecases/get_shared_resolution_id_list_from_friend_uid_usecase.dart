import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetSharedResolutionIdListFromFriendUidUsecase {
  GetSharedResolutionIdListFromFriendUidUsecase(
    this._resolutionRepository,
  );

  final ResolutionRepository _resolutionRepository;

  EitherFuture<List<String>> call({
    required String targetUid,
  }) {
    return _resolutionRepository.getResolutionIdListSharedToMe(from: targetUid);
  }
}
