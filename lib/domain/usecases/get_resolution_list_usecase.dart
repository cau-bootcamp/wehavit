import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_model.dart';
import 'package:wehavit/domain/repositories/resolution_repository.dart';

final getResolutionListUseCaseProvider =
    Provider<GetResolutionListUsecase>((ref) {
  final resolutionRepository = ref.watch(resolutionRepositoryProvider);
  return GetResolutionListUsecase(resolutionRepository);
});

class GetResolutionListUsecase
    implements FutureUseCase<List<ResolutionModel>?, NoParams> {
  GetResolutionListUsecase(this._resolutionRepository);

  final ResolutionRepository _resolutionRepository;

  @override
  Future<Either<Failure, List<ResolutionModel>>> call(NoParams params) async {
    return _resolutionRepository.getActiveResolutionModelList();
  }
}
