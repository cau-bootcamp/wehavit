import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/group_post/model/send_reaction_state_model.dart';
import 'package:wehavit/presentation/state/user_data/my_user_data_provider.dart';

class SendReactionStateModelNotifier extends StateNotifier<SendReactionStateModel> {
  SendReactionStateModelNotifier(
    super._state,
    this._sendEmojiReactionToConfirmPostUsecase,
    this._sendCommentReactionToConfirmPostUsecase,
    this._sendQuickShotReactionToConfirmPostUsecase,
  );

  final SendEmojiReactionToConfirmPostUsecase _sendEmojiReactionToConfirmPostUsecase;
  final SendCommentReactionToConfirmPostUsecase _sendCommentReactionToConfirmPostUsecase;
  final SendQuickShotReactionToConfirmPostUsecase _sendQuickShotReactionToConfirmPostUsecase;

  void addEmoji(int emojiIndex) {
    state.sendingEmojis[emojiIndex] += 1;
  }

  EitherFuture<bool> sendReaction() async {
    if (state.confirmPostEntity == null) {
      return Future.value(left(const Failure('SendReactionStateModel에 ConfirmPostentity가 로드되지 않음')));
    }

    if (state.sendingComment.isNotEmpty) {
      return Future.value(right(true));
    }

    if (state.emojiSendCount != 0) {
      return _sendEmojiReactionToConfirmPostUsecase.call((state.confirmPostEntity!, state.sendingEmojis));
    }

    if (state.sendingQuickshotUrl.isNotEmpty) {
      return Future.value(right(true));
    }

    return Future.value(left(const Failure('')));
  }
}

final sendReactionStateModelNotifierProvider = StateNotifierProvider.family
    .autoDispose<SendReactionStateModelNotifier, SendReactionStateModel, ConfirmPostEntity>((ref, confirmPostEntity) {
  final myUserEntity = ref.read(getMyUserDataProvider).value;

  return SendReactionStateModelNotifier(
    SendReactionStateModel(myUserEntity, confirmPostEntity),
    ref.read(sendEmojiReactionToConfirmPostUsecaseProvider),
    ref.read(sendCommentReactionToConfirmPostUsecaseProvider),
    ref.read(sendQuickShotReactionToConfirmPostUsecaseProvider),
  );
});
