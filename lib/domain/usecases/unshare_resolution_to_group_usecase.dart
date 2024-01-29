import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class ShareResolutionToGroupUsecase
    implements FutureUseCase<void, (String, String)> {
  ShareResolutionToGroupUsecase(this._resolutionRepository);

  final ResolutionRepository _resolutionRepository;

  @override
  EitherFuture<void> call((String, String) params) async {
    return await _resolutionRepository.shareResolutionToGroup(
      params.$1,
      params.$2,
    );
  }
}
