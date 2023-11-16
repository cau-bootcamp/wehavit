import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/reaction/data/repository/confirm_post_reaction_repository_impl.dart';
import 'package:wehavit/features/swipe_view/domain/model/reaction_model.dart';

final confirmPostReactionRepositoryProvider =
    Provider<ConfirmPostReactionRepository>((ref) {
  return ConfirmPostReactionRepositoryImpl(ref);
});

abstract class ConfirmPostReactionRepository {
  EitherFuture<List<ReactionModel>> getReactionNotReadFromLastConfirmPost();
}
