import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';
import 'package:wehavit/features/my_page/domain/repositories/resolution_repository.dart';

class GetResolutionListUseCase
    implements UseCase<List<ResolutionModel>, NoParams> {
  GetResolutionListUseCase(this._resolutionRepository);

  final ResolutionRepository _resolutionRepository;

  @override
  Future<Either<Failure, List<ResolutionModel>>> call(NoParams params) async {
    return await _resolutionRepository.getActiveResolutionModelList();
  }
}
