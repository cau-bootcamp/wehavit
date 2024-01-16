import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/data/repositories/reaction_repository_impl.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_entity.dart';
import 'package:wehavit/domain/repositories/reaction_repository.dart';

final getUnreadReactionListFromLastConfirmPostUsecaseProvider =
    Provider<GetUnreadReactionListFromLastConfirmPostUsecase>((ref) {
  final repository = ref.watch(reactionRepositoryProvider);
  return GetUnreadReactionListFromLastConfirmPostUsecase(repository);
});

class GetUnreadReactionListFromLastConfirmPostUsecase
    extends FutureUseCase<List<ReactionEntity>, NoParams> {
  GetUnreadReactionListFromLastConfirmPostUsecase(
    this._reactionRepository,
  );

  final ReactionRepository _reactionRepository;

  @override
  EitherFuture<List<ReactionEntity>> call(NoParams params) {
    return _reactionRepository.getUnreadReactionFromLastConfirmPost();
  }
}
