import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';

abstract class ReactionRepository {
  EitherFuture<List<ReactionEntity>> getUnreadReactionListAndDelete();

  EitherFuture<bool> addReactionToConfirmPost(
    String targetConfirmPostId,
    ReactionEntity reactionModel,
  );

  EitherFuture<List<ReactionEntity>> getReactionListFromConfirmPost({
    required ConfirmPostEntity entity,
  });
}
