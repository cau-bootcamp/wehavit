import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_entity.dart';

abstract class ReactionRepository {
  EitherFuture<List<ReactionEntity>> getUnreadReactionFromLastConfirmPost();

  EitherFuture<bool> addReactionToConfirmPost(
    String targetConfirmPostId,
    ReactionEntity reactionModel,
  );
}
