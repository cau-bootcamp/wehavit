import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/swipe_view/data/enitty/DEBUG_confirm_post_model.dart';

abstract class SwipeViewDatasource {
  EitherFuture<List<ConfirmPostModel>> fetchLiveWrittenConfirmPostList();
  EitherFuture<List<ConfirmPostModel>> fetchTodayConfirmPostList();
  void postEncourageToConfirmPost();
}
