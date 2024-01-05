import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/domain/repositories/confirm_post_repository.dart';

const int maxIndex = 27;

final getConfirmPostListUsecaseProvider =
    Provider<GetConfirmPostListUsecase>((ref) {
  final confirmPostRepository = ref.watch(confirmPostRepositoryProvider);
  return GetConfirmPostListUsecase(confirmPostRepository);
});

class GetConfirmPostListUsecase
    implements FutureUseCase<List<ConfirmPostEntity>?, NoParams> {
  GetConfirmPostListUsecase(this._confirmPostRepository);

  final ConfirmPostRepository _confirmPostRepository;

  @override
  Future<Either<Failure, List<ConfirmPostEntity>>> call(NoParams params) async {
    return _confirmPostRepository.getConfirmPostModelList(maxIndex);
  }

  Future<Either<Failure, List<ConfirmPostEntity>>>
      getConfirmPostModelListByDate(
    int selectedIndex,
  ) async {
    return _confirmPostRepository.getConfirmPostModelList(selectedIndex);
  }
}
