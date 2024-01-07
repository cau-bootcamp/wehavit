import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/domain/repositories/confirm_post_repository.dart';

final getConfirmPostListUsecaseProvider =
    Provider<GetConfirmPostListUsecase>((ref) {
  final confirmPostRepository = ref.watch(uploadPostRepositoryProvider);
  return GetConfirmPostListUsecase(confirmPostRepository);
});

class GetConfirmPostListUsecase
    implements FutureUseCase<List<ConfirmPostEntity>?, int> {
  GetConfirmPostListUsecase(this._confirmPostRepository);

  final ConfirmPostRepository _confirmPostRepository;

  @override
  Future<Either<Failure, List<ConfirmPostEntity>>> call(
    int selectedIndex,
  ) async {
    return _confirmPostRepository.getConfirmPostModelList(selectedIndex);
  }
}
