import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/effects/effects.dart';
import 'package:wehavit/features/reaction/domain/usecase/get_reaction_not_read_from_last_confirm_post_usecase.dart';
import 'package:wehavit/features/swipe_view/domain/model/reaction_model.dart';
import 'package:wehavit/features/swipe_view/domain/usecase/fetch_user_data_from_id_usecase.dart';
import 'package:wehavit/features/swipe_view/domain/usecase/fetch_user_data_from_id_usecase_provider.dart';

final reactionWidgetManagerProvider =
    StateNotifierProvider<ReactionWidgetManager, ReactionWidgetModel>(
  (ref) {
    ref.onDispose(
      () {
        print("DEBUG ___");
      },
    );
    return ReactionWidgetManager(ref);
  },
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
    fetchUserDataFromIdUsecase = ref.watch(fetchUserDataFromIdUsecaseProvider);
  }

  late final GetReactionNotReadFromLastConfirmPostUsecase
      getReactionNotReadFromLastConfirmPostUsecase;
  late final FetchUserDataFromIdUsecase fetchUserDataFromIdUsecase;

  void addTextMessageBubble(String message, String imageUrl) {
    state.textBubbleAnimationManager.addTextBubble(
      message: message,
      imageUrl: imageUrl,
    );
  }

  void callBackFunction(Offset offset) {
    print("STATE");
    print(offset);
    print(state.emojiFireWork);

    state.emojiFireWork.addFireworkWidget(offset);
  }

  Future<void> drawReactionWidgets() async {
    await getUnreadReactionModelGroupListFromLastConfirmPost();

    for (var reactionModelGroup in state.reactionModelGroupList) {
      final complimenterUserModelFetchResult =
          await fetchUserDataFromIdUsecase(reactionModelGroup.complimenterUid);

      final userImageUrl = complimenterUserModelFetchResult.fold(
        (failure) {
          return 'https://thepets.cafe24.com/data/editor/1601/thumb-bc7f97593a2e6ecbe24b8eb79f4e357f_1453230382_494_600x483.jpg';
        },
        (userModel) {
          return userModel.imageUrl;
        },
      );

      state.balloonManager.addBalloon(imageUrl: userImageUrl);
    }
  }

  Future<void> getUnreadReactionModelGroupListFromLastConfirmPost() async {
    final fetchResult =
        await getReactionNotReadFromLastConfirmPostUsecase.call(NoParams());
    fetchResult.fold(
      (failure) {
        debugPrint(failure.toString());
        state.reactionModelList = [];
      },
      (result) {
        result.sort((a, b) => a.complementerUid.compareTo(b.complementerUid));
        state.reactionModelList = result;
      },
    );

    final complementerList =
        state.reactionModelList.map((e) => e.complementerUid).toSet().toList();

    state.reactionModelGroupList = complementerList
        .map(
          (complimenterUid) =>
              ReactionModelGroup(complimenterUid: complimenterUid),
        )
        .toList();

    state.reactionModelList.map((reaction) {
      final index = state.reactionModelGroupList.indexWhere((modelGroup) =>
          modelGroup.complimenterUid == reaction.complementerUid);
      switch (ReactionType.values[reaction.reactionType]) {
        case ReactionType.comment:
          state.reactionModelGroupList[index].textReactionModel = reaction;
          break;
        case ReactionType.emoji:
          state.reactionModelGroupList[index].emojiReacionModelList
              .add(reaction);
          break;
        case ReactionType.instantPhoto:
          state.reactionModelGroupList[index].imageReacionModel = reaction;
          break;
      }
    });
    print("HERE2");
    print(state.emojiFireWork);
    ;
  }
}

class ReactionWidgetModel {
  // reaction variables
  List<ReactionModel> reactionModelList = [];
  late List<ReactionModelGroup> reactionModelGroupList;

  // animation variables
  late Map<Key, BalloonWidget> balloonWidgets;
  late Map<Key, TextBubbleFrameWidget> textBubbleWidgets;

  late TextBubbleAnimationManager textBubbleAnimationManager;
  late BalloonManager balloonManager;

  EmojiFireWorkManager emojiFireWork = EmojiFireWorkManager(
    emojiAsset: const AssetImage('assets/images/emoji_3d/heart_suit_3d.png'),
  );
}

class ReactionModelGroup {
  ReactionModelGroup({
    required this.complimenterUid,
  });

  String complimenterUid;
  List<ReactionModel> emojiReacionModelList = [];
  ReactionModel? imageReacionModel;
  ReactionModel? textReactionModel;
}
