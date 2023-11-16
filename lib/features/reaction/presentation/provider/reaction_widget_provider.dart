import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/effects/effects.dart';
import 'package:wehavit/features/reaction/domain/usecase/get_reaction_not_read_from_last_confirm_post_usecase.dart';
import 'package:wehavit/features/swipe_view/domain/model/reaction_model.dart';

final reactionWidgetManagerProvider =
    StateNotifierProvider<ReactionWidgetManager, ReactionWidgetModel>(
  (ref) => ReactionWidgetManager(ref),
);

class ReactionWidgetManager extends StateNotifier<ReactionWidgetModel> {
  ReactionWidgetManager(Ref ref) : super(ReactionWidgetModel()) {
    state.balloonWidgets = ref.watch(balloonManagerProvider);
    state.balloonManager = ref.read(balloonManagerProvider.notifier);

    state.balloonManager.onTapCallbackWithTappedPositionOffset =
        callBackFunction;

    state.textBubbleWidgets = ref.watch(textBubbleAnimationManagerProvider);
    state.textBubbleAnimationManager =
        ref.read(textBubbleAnimationManagerProvider.notifier);

    getReactionNotReadFromLastConfirmPostUsecase =
        ref.watch(getReactionNotReadFromLastConfirmPostUsecaseProvider);
  }

  late final GetReactionNotReadFromLastConfirmPostUsecase
      getReactionNotReadFromLastConfirmPostUsecase;

  void addTextMessageBubble(String message, String imageUrl) {
    state.textBubbleAnimationManager.addTextBubble(
      message: message,
      imageUrl: imageUrl,
    );
  }

  void callBackFunction(Offset offset) {
    state.emojiFireWork.addFireworkWidget(offset);
  }

  EitherFuture<List<ReactionModel>> getReactionsNotReadFromLastConfirmPost() {
    return getReactionNotReadFromLastConfirmPostUsecase.call(NoParams());
  }
}

class ReactionWidgetModel {
  late Map<Key, BalloonWidget> balloonWidgets;
  late Map<Key, TextBubbleFrameWidget> textBubbleWidgets;

  late TextBubbleAnimationManager textBubbleAnimationManager;
  late BalloonManager balloonManager;

  EmojiFireWorkManager emojiFireWork = EmojiFireWorkManager(
    emojiAsset: const AssetImage('assets/images/emoji_3d/heart_suit_3d.png'),
  );
}
