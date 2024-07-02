import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class SetResolutionDeactiveUsecase {
  SetResolutionDeactiveUsecase(
    this._resolutionRepository,
  );

  final ResolutionRepository _resolutionRepository;

  EitherFuture<void> call({
    required String resolutionId,
    required ResolutionEntity entity,
  }) async {
    return _resolutionRepository.updateResolutionEntity(
      targetResolutionId: resolutionId,
      newEntity: entity.copyWith(isActive: false),
    );
  }
}
