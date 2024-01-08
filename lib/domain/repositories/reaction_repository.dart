import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_entity.dart';
import 'package:wehavit/presentation/reaction/data/repository/get_reaction_repository_impl.dart';

final reactionRepositoryProvider = Provider<ReactionRepository>((ref) {
  return ReactionRepositoryImpl(ref);
});

abstract class ReactionRepository {
  EitherFuture<List<ReactionEntity>> getUnreadReactionFromLastConfirmPost();

  EitherFuture<bool> addReactionToConfirmPost(
    String targetConfirmPostId,
    ReactionEntity reactionModel,
  );
}
