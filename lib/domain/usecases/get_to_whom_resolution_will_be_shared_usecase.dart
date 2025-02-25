import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetToWhomResolutionWillBeSharedUsecase {
  GetToWhomResolutionWillBeSharedUsecase(this._resolutionRepository);

  final ResolutionRepository _resolutionRepository;

  EitherFuture<List<GroupEntity>> call({required String resolutionId}) {
    return _resolutionRepository.getResolutionSharingTargetGroupList(resolutionId);
  }
}
