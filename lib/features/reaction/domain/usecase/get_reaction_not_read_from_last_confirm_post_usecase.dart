import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/reaction/domain/repository/get_reaction_repository.dart';
import 'package:wehavit/features/swipe_view/domain/model/reaction_model.dart';

final getReactionNotReadFromLastConfirmPostUsecaseProvider =
    Provider<GetReactionNotReadFromLastConfirmPostUsecase>((ref) {
  final repository = ref.watch(confirmPostReactionRepositoryProvider);
  return GetReactionNotReadFromLastConfirmPostUsecase(repository);
});

class GetReactionNotReadFromLastConfirmPostUsecase
    extends UseCase<List<ReactionModel>, NoParams> {
  GetReactionNotReadFromLastConfirmPostUsecase(
    this._confirmPostReactionRepository,
  );

  final ConfirmPostReactionRepository _confirmPostReactionRepository;

  @override
  EitherFuture<List<ReactionModel>> call(NoParams params) {
    return _confirmPostReactionRepository
        .getReactionNotReadFromLastConfirmPost();
  }
}
