import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_entity.dart';
import 'package:wehavit/presentation/swipe_view/data/repository/swipe_view_repository_impl.dart';

final swipeViewRepositoryProvider = Provider<SwipeViewRepository>((ref) {
  return SwipeViewRepositoryImpl(ref);
});

abstract class SwipeViewRepository {
  EitherFuture<bool> addReactionToConfirmPost(
    String targetConfirmPostId,
    ReactionEntity reactionModel,
  );
}
