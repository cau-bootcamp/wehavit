import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/repositories/wehavit_data_repository_impl.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_entity.dart';

final reactionRepositoryProvider = Provider<ReactionRepository>((ref) {
  return ref.watch(wehavitDataRepositoryProvider);
});

abstract class ReactionRepository {
  EitherFuture<List<ReactionEntity>> getUnreadReactionFromLastConfirmPost();

  EitherFuture<bool> addReactionToConfirmPost(
    String targetConfirmPostId,
    ReactionEntity reactionModel,
  );
}
