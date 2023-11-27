import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';
import 'package:wehavit/features/my_page/domain/repositories/resolution_repository.dart';
import 'package:wehavit/features/my_page/domain/repositories/resolution_repository_provider.dart';

final getMyResolutionListUsecaseProvider =
    Provider<GetMyResolutionListUsecase>((ref) {
  final resolutionRepository = ref.watch(resolutionRepositoryProvider);
  return GetMyResolutionListUsecase(
    resolutionRepository,
  );
});

class GetMyResolutionListUsecase
    extends UseCase<List<ResolutionModel>, NoParams> {
  GetMyResolutionListUsecase(this._resolutionRepository);

  final ResolutionRepository _resolutionRepository;

  @override
  EitherFuture<List<ResolutionModel>> call(NoParams params) {
    return _resolutionRepository.getActiveResolutionModelList();
  }
}
