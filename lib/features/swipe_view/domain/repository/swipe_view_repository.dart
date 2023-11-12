import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/live_writing/domain/models/confirm_post_model.dart';
import 'package:wehavit/features/swipe_view/domain/model/reaction_model.dart';

abstract class SwipeViewRepository {
  EitherFuture<List<ConfirmPostModel>> getLiveWrittenConformPostList();
  EitherFuture<List<ConfirmPostModel>> getTodayConfrmPostList();
  EitherFuture<bool> addReactionToConfirmPost(
      String targetConfirmPostId, ReactionModel reactionModel);
}
