import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetTargetResolutionEntityUsecase {
  GetTargetResolutionEntityUsecase(
    this._resolutionRepository,
  );

  final ResolutionRepository _resolutionRepository;

  EitherFuture<ResolutionEntity> call({
    required String targetUserId,
    required String targetResolutionId,
  }) async {
    return _resolutionRepository.getTargetResolutionEntity(
      targetUserId: targetUserId,
      targetResolutionId: targetResolutionId,
    );
  }
}
