import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/resolution_model.dart';
import 'package:wehavit/domain/repositories/resolution_repository.dart';

final uploadResolutionUsecaseProvider =
    Provider<UploadResolutionUseCase>((ref) {
  final resolutionRepository = ref.watch(resolutionRepositoryProvider);
  return UploadResolutionUseCase(resolutionRepository);
});

class UploadResolutionUseCase implements UseCase<bool, ResolutionModel> {
  UploadResolutionUseCase(this._resolutionRepository);

  final ResolutionRepository _resolutionRepository;

  @override
  EitherFuture<bool> call(ResolutionModel newModel) async {
    return await _resolutionRepository.uploadResolutionModel(newModel);
  }
}
