import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/common/utils/no_params.dart';
import 'package:wehavit/data/repositories/reaction_repository_impl.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_entity.dart';
import 'package:wehavit/domain/repositories/reaction_repository.dart';

final getUnreadReactionListUsecaseProvider =
    Provider<GetUnreadReactionListUsecase>((ref) {
  final repository = ref.watch(reactionRepositoryProvider);
  return GetUnreadReactionListUsecase(repository);
});

class GetUnreadReactionListUsecase
    extends FutureUseCase<List<ReactionEntity>, NoParams> {
  GetUnreadReactionListUsecase(
    this._reactionRepository,
  );

  final ReactionRepository _reactionRepository;

  @override
  EitherFuture<List<ReactionEntity>> call(NoParams params) {
    return _reactionRepository.getUnreadReactionList();
  }
}
