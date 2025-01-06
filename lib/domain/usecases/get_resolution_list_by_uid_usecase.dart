import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetResolutionListByUserIdUsecase extends FutureUseCase<List<ResolutionEntity>, String> {
  GetResolutionListByUserIdUsecase(
    this._resolutionRepository,
  );

  final ResolutionRepository _resolutionRepository;

  @override
  EitherFuture<List<ResolutionEntity>> call(String params) {
    return _resolutionRepository.getActiveResolutionEntityList(params);
  }
}
