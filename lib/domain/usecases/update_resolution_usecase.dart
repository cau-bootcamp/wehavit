import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class UpdateResolutionUseCase {
  UpdateResolutionUseCase(
    this._resolutionRepository,
  );

  final ResolutionRepository _resolutionRepository;

  EitherFuture<void> call({
    required String resolutionId,
    required ResolutionEntity newEntity,
  }) async {
    return _resolutionRepository.updateResolutionEntity(
      targetResolutionId: resolutionId,
      newEntity: newEntity,
    );
  }
}
