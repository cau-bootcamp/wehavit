import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';
import 'package:wehavit/features/my_page/domain/repositories/resolution_repository.dart';

class UploadResolutionUseCase implements UseCase<bool, ResolutionModel> {
  UploadResolutionUseCase(this._resolutionRepository);

  final ResolutionRepository _resolutionRepository;

  @override
  EitherFuture<bool> call(ResolutionModel newModel) async {
    return await _resolutionRepository.uploadResolutionModel(newModel);
  }
}
