import 'package:fpdart/src/either.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/swipe_view/data/enitty/DEBUG_confirm_post_model.dart';
import 'package:wehavit/features/swipe_view/domain/repository/swipe_view_repository.dart';

class GetTodayConfirmPostListUsecase
    extends UseCase<List<ConfirmPostModel>, NoParams> {
  GetTodayConfirmPostListUsecase(this._swipeViewRepository);
  final SwipeViewRepository _swipeViewRepository;

  @override
  EitherFuture<List<ConfirmPostModel>> call(NoParams params) async {
    return _swipeViewRepository.getTodayConfrmPostList();
  }
}
