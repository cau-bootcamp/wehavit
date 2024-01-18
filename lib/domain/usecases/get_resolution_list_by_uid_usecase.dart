import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/repositories/repositories.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

final getResolutionListByUserIdUsecaseProvider =
    Provider<GetResolutionListByUserIdUsecase>((ref) {
  final resolutionRepository = ref.watch(resolutionRepositoryProvider);
  return GetResolutionListByUserIdUsecase(resolutionRepository);
});

class GetResolutionListByUserIdUsecase
    extends FutureUseCase<List<ResolutionEntity>, String> {
  GetResolutionListByUserIdUsecase(
    this._resolutionRepository,
  );

  final ResolutionRepository _resolutionRepository;

  @override
  EitherFuture<List<ResolutionEntity>> call(String params) {
    return _resolutionRepository.getActiveResolutionEntityList(params);
  }
}
