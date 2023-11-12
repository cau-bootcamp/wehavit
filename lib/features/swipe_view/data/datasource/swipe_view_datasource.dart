import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';

abstract class SwipeViewDatasource {
  EitherFuture<List<ConfirmPostModel>> fetchLiveWrittenConfirmPostList();
  EitherFuture<List<ConfirmPostModel>> fetchTodayConfirmPostList();
}
