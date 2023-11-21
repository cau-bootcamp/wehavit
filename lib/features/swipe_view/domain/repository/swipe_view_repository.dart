import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/swipe_view/domain/model/reaction_model.dart';

abstract class SwipeViewRepository {
  EitherFuture<bool> addReactionToConfirmPost(
    String targetConfirmPostId,
    ReactionModel reactionModel,
  );
}
