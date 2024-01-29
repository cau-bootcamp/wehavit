import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class UnShareResolutionToGroupUsecase
    implements FutureUseCase<void, (String, String)> {
  UnShareResolutionToGroupUsecase(this._resolutionRepository);

  final ResolutionRepository _resolutionRepository;

  @override
  EitherFuture<void> call((String, String) params) async {
    return await _resolutionRepository.unshareResolutionToGroup(
      params.$1,
      params.$2,
    );
  }
}
