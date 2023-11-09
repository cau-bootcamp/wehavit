import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/models/user_model/user_model.dart';
import 'package:wehavit/features/swipe_view/domain/model/reaction_model.dart';
import 'package:wehavit/features/swipe_view/domain/usecase/fetch_user_data_from_id_usecase.dart';
import 'package:wehavit/features/swipe_view/domain/usecase/fetch_user_data_from_id_usecase_provider.dart';
import 'package:wehavit/features/swipe_view/domain/usecase/send_reaction_to_target_confirm_post.dart';
import 'package:wehavit/features/swipe_view/domain/usecase/send_reaction_to_target_confirm_post_provider.dart';

final swipeViewCellUserModelProvider = StateNotifierProvider<
    SwipeViewCellUserModelProvider,
    Either<Failure, UserModel>>((ref) => SwipeViewCellUserModelProvider(ref));

class SwipeViewCellUserModelProvider
    extends StateNotifier<Either<Failure, UserModel>> {
  SwipeViewCellUserModelProvider(Ref ref) : super(Right(UserModel.dummyModel)) {
    _fetchUserDataFromIdUsecase = ref.watch(fetchUserDataFromIdUsecaseProvider);
    _sendReactionToTargetConfirmPostUsecase =
        ref.watch(sendReactionToTargetConfirmPostUsecaseProvider);
  }
  late final FetchUserDataFromIdUsecase _fetchUserDataFromIdUsecase;
  late final SendReactionToTargetConfirmPostUsecase
      _sendReactionToTargetConfirmPostUsecase;

  void getUserModelFromUi(String userId) async {
    final userModelFetchResult = await _fetchUserDataFromIdUsecase.call(userId);
    state = userModelFetchResult;
  }

  Future<void> sendReactionToTargetConfirmPost(
      String targetConfirmPostId, ReactionModel reactionModel) async {
    await _sendReactionToTargetConfirmPostUsecase
        .call((targetConfirmPostId, reactionModel));
  }
}
