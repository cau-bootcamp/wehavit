import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/repositories/resolution_repository_impl.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_entity.dart';
import 'package:wehavit/domain/repositories/resolution_repository.dart';

final getResolutionListByUserIdUsecaseProvider =
    Provider<GetResolutionListByUserIdUsecase>((ref) {
  final resolutionRepository = ref.watch(resolutionRepositoryProvider);
  return GetResolutionListByUserIdUsecase(
    resolutionRepository,
  );
});

class GetResolutionListByUserIdUsecase
    extends FutureUseCase<List<ResolutionEntity>, String> {
  GetResolutionListByUserIdUsecase(this._resolutionRepository);

  final ResolutionRepository _resolutionRepository;

  @override
  EitherFuture<List<ResolutionEntity>> call(String params) {
    return _resolutionRepository.getActiveResolutionModelList(params);
  }
}
