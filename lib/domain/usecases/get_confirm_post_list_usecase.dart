import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/confirm_post_model.dart';
import 'package:wehavit/domain/repositories/confirm_post_repository.dart';

const int maxIndex = 27;

final getConfirmPostListUsecaseProvider =
    Provider<GetConfirmPostListUsecase>((ref) {
  final confirmPostRepository = ref.watch(confirmPostRepositoryProvider);
  return GetConfirmPostListUsecase(confirmPostRepository);
});

class GetConfirmPostListUsecase
    implements UseCase<List<HomeConfirmPostModel>?, NoParams> {
  GetConfirmPostListUsecase(this._confirmPostRepository);

  final ConfirmPostRepository _confirmPostRepository;

  @override
  Future<Either<Failure, List<HomeConfirmPostModel>>> call(
      NoParams params) async {
    return _confirmPostRepository.getConfirmPostModelList(maxIndex);
  }

  Future<Either<Failure, List<HomeConfirmPostModel>>>
      getConfirmPostModelListByDate(
    int selectedIndex,
  ) async {
    return _confirmPostRepository.getConfirmPostModelList(selectedIndex);
  }
}
