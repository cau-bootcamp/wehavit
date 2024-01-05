import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_model.dart';
import 'package:wehavit/domain/repositories/resolution_repository.dart';

final getMyResolutionListUsecaseProvider =
    Provider<GetMyResolutionListUsecase>((ref) {
  final resolutionRepository = ref.watch(resolutionRepositoryProvider);
  return GetMyResolutionListUsecase(
    resolutionRepository,
  );
});

class GetMyResolutionListUsecase
    extends FutureUseCase<List<ResolutionModel>, NoParams> {
  GetMyResolutionListUsecase(this._resolutionRepository);

  final ResolutionRepository _resolutionRepository;

  @override
  EitherFuture<List<ResolutionModel>> call(NoParams params) {
    return _resolutionRepository.getActiveResolutionModelList();
  }
}
