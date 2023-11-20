import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/reaction/domain/repository/get_reaction_repository.dart';
import 'package:wehavit/features/swipe_view/domain/model/reaction_model.dart';

final getReactionUnreadFromLastConfirmPostUsecaseProvider =
    Provider<GetReactionUnreadFromLastConfirmPostUsecase>((ref) {
  final repository = ref.watch(confirmPostReactionRepositoryProvider);
  return GetReactionUnreadFromLastConfirmPostUsecase(repository);
});

class GetReactionUnreadFromLastConfirmPostUsecase
    extends UseCase<List<ReactionModel>, NoParams> {
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
