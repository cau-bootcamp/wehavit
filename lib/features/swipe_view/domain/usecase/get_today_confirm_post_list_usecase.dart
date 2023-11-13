import 'package:wehavit/common/common.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/live_writing/domain/repositories/confirm_post_repository.dart';

class GetTodayConfirmPostListUsecase
    extends UseCase<List<ConfirmPostModel>, NoParams> {
  // GetTodayConfirmPostListUsecase(this._swipeViewRepository);
  // final SwipeViewRepository _swipeViewRepository;
  GetTodayConfirmPostListUsecase(this._confirmPostRepository);
  final ConfirmPostRepository _confirmPostRepository;

  @override
  EitherFuture<List<ConfirmPostModel>> call(NoParams params) async {
    return await _confirmPostRepository.getAllConfirmPosts();
  }
}
