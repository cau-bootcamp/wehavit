import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';

abstract class ReactionRepository {
  EitherFuture<List<ReactionEntity>> getUnreadReactionListAndDelete();

  EitherFuture<bool> addReactionToConfirmPost(
    ConfirmPostEntity targetEntity,
    ReactionEntity reactionModel,
  );

  EitherFuture<List<ReactionEntity>> getReactionListFromConfirmPost({
    required ConfirmPostEntity entity,
  });
}
