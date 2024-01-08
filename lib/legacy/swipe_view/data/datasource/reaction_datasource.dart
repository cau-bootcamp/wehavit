import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_entity.dart';

abstract class ReactionDatasource {
  EitherFuture<bool> sendReactionToTargetConfirmPost(
    String targetConfirmPostId,
    ReactionEntity reactionModel,
  );

  EitherFuture<List<ReactionEntity>> getReactionUnreadFromLastConfirmPost();
}
