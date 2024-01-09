import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/data/repositories/resolution_repository_impl.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_entity.dart';
import 'package:wehavit/domain/repositories/resolution_repository.dart';

final uploadResolutionUsecaseProvider =
    Provider<UploadResolutionUseCase>((ref) {
  final resolutionRepository = ref.watch(resolutionRepositoryProvider);
  return UploadResolutionUseCase(resolutionRepository);
});

class UploadResolutionUseCase implements FutureUseCase<bool, ResolutionEntity> {
  UploadResolutionUseCase(this._resolutionRepository);

  final ResolutionRepository _resolutionRepository;

  @override
  EitherFuture<bool> call(ResolutionEntity newEntity) async {
    return await _resolutionRepository.uploadResolutionEntity(newEntity);
  }
}
