import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

class UploadReactionToTargetConfirmPostUsecase
    extends FutureUseCase<void, (String, ReactionEntity)> {
  UploadReactionToTargetConfirmPostUsecase(this._reactionRepository);
  final ReactionRepository _reactionRepository;

  @override
  EitherFuture<bool> call((String, ReactionEntity) params) {
    return _reactionRepository.addReactionToConfirmPost(params.$1, params.$2);
  }
}
