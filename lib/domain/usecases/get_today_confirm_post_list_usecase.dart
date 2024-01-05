import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/confirm_post_entity/confirm_post_entity.dart';
import 'package:wehavit/domain/repositories/confirm_post_repository.dart';
import 'package:wehavit/domain/repositories/home_confirm_post_repository.dart';

final getTodayConfirmPostListUsecaseProvider =
    Provider<GetTodayConfirmPostListUsecase>((ref) {
  final confirmPostRepository = ref.watch(confirmPostRepositoryProvider);
  return GetTodayConfirmPostListUsecase(confirmPostRepository);
});

class GetTodayConfirmPostListUsecase
    extends FutureUseCase<List<ConfirmPostEntity>, NoParams> {
  // GetTodayConfirmPostListUsecase(this._swipeViewRepository);
  // final SwipeViewRepository _swipeViewRepository;
  GetTodayConfirmPostListUsecase(this._confirmPostRepository);
  final ConfirmPostRepository _confirmPostRepository;

  @override
  EitherFuture<List<ConfirmPostEntity>> call(NoParams params) async {
    // return await _confirmPostRepository.getAllConfirmPosts();
    throw UnimplementedError();
  }
}
