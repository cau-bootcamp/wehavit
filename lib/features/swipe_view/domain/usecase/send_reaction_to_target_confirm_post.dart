import 'package:wehavit/common/usecases/usecase.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/swipe_view/domain/model/reaction_model.dart';
import 'package:wehavit/features/swipe_view/domain/repository/swipe_view_repository.dart';

class SendReactionToTargetConfirmPostUsecase
    extends UseCase<void, (String, ReactionModel)> {
  SendReactionToTargetConfirmPostUsecase(this._swipeViewRepository);
  final SwipeViewRepository _swipeViewRepository;

  @override
  EitherFuture<bool> call((String, ReactionModel) params) {
    return _swipeViewRepository.addReactionToConfirmPost(params.$1, params.$2);
  }
}
