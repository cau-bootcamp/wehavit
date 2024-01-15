import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/repositories/resolution_repository_impl.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_entity.dart';
import 'package:wehavit/domain/repositories/resolution_repository.dart';

final getMyResolutionListByUserIdUsecaseProvider =
    Provider<GetMyResolutionListByUserIdUsecase>((ref) {
  final resolutionRepository = ref.watch(resolutionRepositoryProvider);
  return GetMyResolutionListByUserIdUsecase(
    resolutionRepository,
  );
});

class GetMyResolutionListByUserIdUsecase
    extends FutureUseCase<List<ResolutionEntity>, String> {
  GetMyResolutionListByUserIdUsecase(this._resolutionRepository);

  final ResolutionRepository _resolutionRepository;

  @override
  EitherFuture<List<ResolutionEntity>> call(String params) {
    // current user id?
    final temp = _resolutionRepository
        .getActiveResolutionEntityList('69dlXoGSBKhzrySuhb8t9MvqzdD3');
    print(temp);
    return temp;

    // return _resolutionRepository
    //     .getActiveResolutionModelList('69dlXoGSBKhzrySuhb8t9MvqzdD3');
  }
}
