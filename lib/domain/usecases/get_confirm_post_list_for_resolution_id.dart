import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/domain/repositories/confirm_post_repository.dart';

final getConfirmPostListForResolutionIdUsecaseProvider =
    Provider<GetConfirmPostListForResolutionIdUsecase>((ref) {
  final confirmPostRepository = ref.watch(confirmPostRepositoryProvider);
  return GetConfirmPostListForResolutionIdUsecase(confirmPostRepository);
});

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
