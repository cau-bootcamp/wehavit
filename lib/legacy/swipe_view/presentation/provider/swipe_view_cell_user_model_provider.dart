import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/domain/entities/reaction_entity/reaction_entity.dart';
import 'package:wehavit/domain/entities/user_data_entity/user_data_entity.dart';
import 'package:wehavit/domain/usecases/fetch_user_data_from_id_usecase.dart';
import 'package:wehavit/domain/usecases/upload_reaction_to_target_confirm_post.dart';

final swipeViewCellUserModelProvider = StateNotifierProvider<
        SwipeViewCellUserModelProvider, Either<Failure, UserDataEntity>>(
    (ref) => SwipeViewCellUserModelProvider(ref));

class SwipeViewCellUserModelProvider
    extends StateNotifier<Either<Failure, UserDataEntity>> {
  SwipeViewCellUserModelProvider(Ref ref)
      : super(Right(UserDataEntity.dummyModel)) {
    _fetchUserDataFromIdUsecase = ref.watch(fetchUserDataFromIdUsecaseProvider);
    _sendReactionToTargetConfirmPostUsecase =
        ref.watch(uploadReactionToTargetConfirmPostUsecaseProvider);
  }
  late final FetchUserDataFromIdUsecase _fetchUserDataFromIdUsecase;
  late final UploadReactionToTargetConfirmPostUsecase
      _sendReactionToTargetConfirmPostUsecase;

  void getUserModelFromUi(String userId) async {
    final userModelFetchResult = await _fetchUserDataFromIdUsecase.call(userId);
    state = userModelFetchResult;
  }

  Future<void> sendReactionToTargetConfirmPost(
    String targetConfirmPostId,
    ReactionEntity reactionModel,
  ) async {
    await _sendReactionToTargetConfirmPostUsecase
        .call((targetConfirmPostId, reactionModel));
  }
}
