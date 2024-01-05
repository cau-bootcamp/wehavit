import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_model.dart';
import 'package:wehavit/presentation/reaction/data/repository/get_reaction_repository_impl.dart';

final confirmPostReactionRepositoryProvider =
    Provider<ConfirmPostReactionRepository>((ref) {
  return ConfirmPostReactionRepositoryImpl(ref);
});

abstract class ConfirmPostReactionRepository {
  EitherFuture<List<ReactionModel>> getReactionUnreadFromLastConfirmPost();
}
