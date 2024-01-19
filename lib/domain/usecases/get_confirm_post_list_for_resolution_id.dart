import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetConfirmPostListForResolutionIdUsecase
    extends FutureUseCase<List<ConfirmPostEntity>, String> {
  GetConfirmPostListForResolutionIdUsecase(this._confirmPostRepository);

  final ConfirmPostRepository _confirmPostRepository;

  @override
  EitherFuture<List<ConfirmPostEntity>> call(params) {
    return _confirmPostRepository.getConfirmPostEntityListByResolutionId(
      resolutionId: params,
    );
  }
}
