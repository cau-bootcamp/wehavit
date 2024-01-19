import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class UploadResolutionUseCase implements FutureUseCase<bool, ResolutionEntity> {
  UploadResolutionUseCase(this._resolutionRepository);

  final ResolutionRepository _resolutionRepository;

  @override
  EitherFuture<bool> call(ResolutionEntity newEntity) async {
    return await _resolutionRepository.uploadResolutionEntity(newEntity);
  }
}
