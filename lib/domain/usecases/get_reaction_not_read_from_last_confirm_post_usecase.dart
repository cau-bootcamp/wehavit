import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_model.dart';
import 'package:wehavit/domain/repositories/get_reaction_repository.dart';

final getReactionUnreadFromLastConfirmPostUsecaseProvider =
    Provider<GetReactionUnreadFromLastConfirmPostUsecase>((ref) {
  final repository = ref.watch(confirmPostReactionRepositoryProvider);
  return GetReactionUnreadFromLastConfirmPostUsecase(repository);
});

class GetReactionUnreadFromLastConfirmPostUsecase
    extends FutureUseCase<List<ReactionModel>, NoParams> {
  GetReactionUnreadFromLastConfirmPostUsecase(
    this._confirmPostReactionRepository,
  );

  final ConfirmPostReactionRepository _confirmPostReactionRepository;

  @override
  EitherFuture<List<ReactionModel>> call(NoParams params) {
    return _confirmPostReactionRepository
        .getReactionUnreadFromLastConfirmPost();
  }
}
