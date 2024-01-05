import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_model.dart';
import 'package:wehavit/domain/repositories/swipe_view_repository.dart';

final sendReactionToTargetConfirmPostUsecaseProvider =
    Provider<SendReactionToTargetConfirmPostUsecase>((ref) {
  final swipeViewRepository = ref.watch(swipeViewRepositoryProvider);
  return SendReactionToTargetConfirmPostUsecase(swipeViewRepository);
});

class SendReactionToTargetConfirmPostUsecase
    extends UseCase<void, (String, ReactionModel)> {
  SendReactionToTargetConfirmPostUsecase(this._swipeViewRepository);
  final SwipeViewRepository _swipeViewRepository;

  @override
  EitherFuture<bool> call((String, ReactionModel) params) {
    return _swipeViewRepository.addReactionToConfirmPost(params.$1, params.$2);
  }
}
