import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/data/repositories/repositories.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/repositories/repositories.dart';

final uploadReactionToTargetConfirmPostUsecaseProvider =
    Provider<UploadReactionToTargetConfirmPostUsecase>((ref) {
  final reactionRepository = ref.watch(reactionRepositoryProvider);
  return UploadReactionToTargetConfirmPostUsecase(reactionRepository);
});

class UploadReactionToTargetConfirmPostUsecase
    extends FutureUseCase<void, (String, ReactionEntity)> {
  UploadReactionToTargetConfirmPostUsecase(this._reactionRepository);
  final ReactionRepository _reactionRepository;

  @override
  EitherFuture<bool> call((String, ReactionEntity) params) {
    return _reactionRepository.addReactionToConfirmPost(params.$1, params.$2);
  }
}
