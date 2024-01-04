import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/reaction_model.dart';

abstract class ReactionDatasource {
  EitherFuture<bool> sendReactionToTargetConfirmPost(
    String targetConfirmPostId,
    ReactionModel reactionModel,
  );

  EitherFuture<List<ReactionModel>> getReactionUnreadFromLastConfirmPost();
}
