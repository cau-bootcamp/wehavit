import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/no_params.dart';
import 'package:wehavit/features/my_page/domain/models/add_resolution_model.dart';
import 'package:wehavit/features/my_page/domain/repositories/resolution_repository.dart';

class UploadResolutionUseCase implements UseCase<bool, AddResolutionModel> {
  UploadResolutionUseCase(this._resolutionRepository);

  final ResolutionRepository _resolutionRepository;

  @override
  Future<Either<Failure, bool>> call(AddResolutionModel newModel) async {
    return await _resolutionRepository.uploadResolutionModel(newModel);
  }
}
