import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_entity.dart';
import 'package:wehavit/domain/repositories/resolution_repository.dart';

final getMyResolutionListUsecaseProvider =
    Provider<GetMyResolutionListUsecase>((ref) {
  final resolutionRepository = ref.watch(resolutionRepositoryProvider);
  return GetMyResolutionListUsecase(
    resolutionRepository,
  );
});

class GetMyResolutionListUsecase
    extends FutureUseCase<List<ResolutionEntity>, NoParams> {
  GetMyResolutionListUsecase(this._resolutionRepository);

  final ResolutionRepository _resolutionRepository;

  @override
  EitherFuture<List<ResolutionEntity>> call(NoParams params) {
    return _resolutionRepository.getActiveResolutionModelList();
  }
}
