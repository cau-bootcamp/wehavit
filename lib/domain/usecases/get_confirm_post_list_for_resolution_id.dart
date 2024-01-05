import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_model.dart';
import 'package:wehavit/domain/repositories/resolution_repository.dart';

final getConfirmPostListForResolutionIdUsecaseProvider =
    Provider<GetConfirmPostListForResolutionIdUsecase>((ref) {
  final resolutionRepository = ref.watch(resolutionRepositoryProvider);
  return GetConfirmPostListForResolutionIdUsecase(resolutionRepository);
});

class GetConfirmPostListForResolutionIdUsecase
    extends UseCase<List<ConfirmPostModel>, String> {
  GetConfirmPostListForResolutionIdUsecase(this._resolutionRepository);

  final ResolutionRepository _resolutionRepository;

  @override
  EitherFuture<List<ConfirmPostModel>> call(params) {
    return _resolutionRepository.getConfirmPostListForResolutionId(
      resolutionId: params,
    );
  }
}
