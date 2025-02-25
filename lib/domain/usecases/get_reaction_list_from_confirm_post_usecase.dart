import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class GetReactionListFromConfirmPostUsecase extends FutureUseCase<List<ReactionEntity>, ConfirmPostEntity> {
  GetReactionListFromConfirmPostUsecase(
    this._reactionRepository,
  );

  final ReactionRepository _reactionRepository;

  @override
  EitherFuture<List<ReactionEntity>> call(
    ConfirmPostEntity params,
  ) {
    return _reactionRepository.getReactionListFromConfirmPost(
      entity: params,
    );
  }
}
