import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/utils.dart';
import 'package:wehavit/features/my_page/domain/usecases/get_resolution_list_usecase_provider.dart';
import 'package:wehavit/features/swipe_view/data/enitty/DEBUG_confirm_post_model.dart';
import 'package:wehavit/features/swipe_view/domain/usecase/get_today_confirm_post_list_usecase.dart';
import 'package:wehavit/features/swipe_view/domain/usecase/get_today_confirm_post_list_usecase_proivder.dart';
import 'package:wehavit/features/swipe_view/presentation/screen/swipe_view.dart';

final swipeViewProvider = StateNotifierProvider<SwipeViewProvider,
    Either<Failure, List<ConfirmPostModel>>>((ref) => SwipeViewProvider(ref));

class SwipeViewProvider
    extends StateNotifier<Either<Failure, List<ConfirmPostModel>>> {
  SwipeViewProvider(Ref ref) : super(const Right([])) {
    _getTodayConfirmPostListUsecase =
        ref.watch(getTodayConfirmPostListUsecaseProvider);
  }

  late final GetTodayConfirmPostListUsecase _getTodayConfirmPostListUsecase;

  Future<void> getTodayConfirmPostList() async {
    state = await _getTodayConfirmPostListUsecase.call(NoParams());
  }
}
