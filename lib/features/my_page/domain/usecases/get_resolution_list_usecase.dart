import 'package:wehavit/common/common.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';
import 'package:wehavit/features/my_page/domain/repositories/resolution_repository.dart';

class GetResolutionListUsecase
    implements UseCase<List<ResolutionModel>, NoParams> {
  GetResolutionListUsecase(this._resolutionRepository);

  final ResolutionRepository _resolutionRepository;

  @override
  EitherFuture<List<ResolutionModel>> call(NoParams params) async {
    return _resolutionRepository.getActiveResolutionModelList();
  }
}
