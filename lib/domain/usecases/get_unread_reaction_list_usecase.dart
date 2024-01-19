import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/common/utils/no_params.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

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
