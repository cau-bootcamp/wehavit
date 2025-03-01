import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/usecases/usecases.dart';
import 'package:wehavit/presentation/effects/effects.dart';
import 'package:wehavit/presentation/reaction/provider/reaction_animation_widget_state_provider.dart';

class ReactionAnimationWidget extends ConsumerStatefulWidget {
  const ReactionAnimationWidget({super.key});

  @override
  ConsumerState<ReactionAnimationWidget> createState() => ReactionAnimationWidgetState();
}

final reactionAnimationWidgetKeyProvider = Provider<GlobalKey<ReactionAnimationWidgetState>>((ref) {
  return GlobalKey<ReactionAnimationWidgetState>();
});

class ReactionAnimationWidgetState extends ConsumerState<ReactionAnimationWidget> {
  late Map<Key, BalloonWidget> _balloonWidgets;
  late Map<Key, TextBubbleFrameWidget> _textBubbleWidgets;

  late BalloonManager _balloonManager;
  late TextBubbleAnimationManager _textBubbleAnimationManager;
  late ReactionAnimationWidgetManager _reactionAnimationWidgetManager;

  late GetUserDataFromIdUsecase _fetchUserDataFromIdUsecase;

  EmojiFireWorkManager emojiFireWorkManager = EmojiFireWorkManager();

  void addTextBubbleAnimation({
    required String message,
    required String imageUrl,
  }) {
    setState(() {
      _textBubbleAnimationManager.addTextBubble(
        message: message,
        imageUrl: imageUrl,
      );
    });
  }

  void addBalloonAnimation({
    required String imageUrl,
    required List<int> emojiCountList,
    required String message,
  }) {
    _balloonManager.addBalloon(
      imageUrl: imageUrl,
      emojiReactionCountList: emojiCountList,
      message: message,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _balloonWidgets = ref.watch(balloonManagerProvider);
    _balloonManager = ref.read(balloonManagerProvider.notifier);
    _balloonManager.onTapCallbackWithTappedPositionOffset = _callBackFunction;

    _textBubbleWidgets = ref.watch(textBubbleAnimationManagerProvider);
    _textBubbleAnimationManager = ref.read(textBubbleAnimationManagerProvider.notifier);

    _reactionAnimationWidgetManager = ref.read(reactionAnimationWidgetManagerProvider.notifier);
    _fetchUserDataFromIdUsecase = ref.watch(getUserDataFromIdUsecaseProvider);

    unawaited(showUnreadReactions());
  }

  @override
  Widget build(BuildContext context) {
    _balloonWidgets = ref.watch(balloonManagerProvider);

    return Container(
      constraints: const BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 100,
            child: Container(
              color: Colors.black26,
            ),
          ),
          Container(
            constraints: const BoxConstraints.expand(),
            child: Stack(
              alignment: Alignment.center,
              children: [
                IgnorePointer(
                  child: Stack(
                    children: emojiFireWorkManager.fireworkWidgets.values.toList(),
                  ),
                ),
                Stack(
                  children: _balloonWidgets.values.toList(),
                ),
              ],
            ),
          ),
          Container(
            constraints: const BoxConstraints.expand(),
            child: Stack(
              children: _textBubbleWidgets.values.toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _callBackFunction(
    Offset offset,
    List<int> emojiReactionCountList,
    String message,
    String userImageUrl,
  ) {
    if (emojiReactionCountList.isNotEmpty) {
      emojiFireWorkManager.addFireworkWidget(
        offset: offset,
        emojiReactionCountList: emojiReactionCountList,
      );
    }

    _textBubbleAnimationManager.addTextBubble(
      message: message,
      imageUrl: userImageUrl,
    );
  }

  Future<void> showUnreadReactions() async {
    final fetchResult = await _reactionAnimationWidgetManager.getUnreadReactionGroupList();

    for (var reactionGroupModel in fetchResult) {
      final fetchUserModelResult = await _fetchUserDataFromIdUsecase.call(
        reactionGroupModel.complimenterUid,
      );

      List<int> emojiCountList;
      if (reactionGroupModel.emojiReacionModelList != null) {
        emojiCountList = List.generate(
          reactionGroupModel.emojiReacionModelList!.first.emoji.length,
          (index) => 0,
        );

        for (var emojiReaction in reactionGroupModel.emojiReacionModelList!) {
          emojiReaction.emoji.forEach((key, value) {
            emojiCountList[int.parse(key.substring(1, 3))] += value;
          });
        }
      } else {
        emojiCountList = [];
      }

      setState(() {
        String userImageUrl;
        if (reactionGroupModel.imageReacionModel != null) {
          userImageUrl = reactionGroupModel.imageReacionModel!.quickShotUrl;
        } else {
          userImageUrl = fetchUserModelResult.fold(
            (failure) {
              return 'https://png.pngtree.com/thumb_back/fh260/background/20210409/pngtree-rules-of-biotex-cat-image_600076.jpg';
            },
            (userModel) {
              return userModel.userImageUrl;
            },
          );
        }

        addBalloonAnimation(
          imageUrl: userImageUrl,
          emojiCountList: emojiCountList,
          message: reactionGroupModel.textReactionModel?.comment ?? '',
        );
      });
    }
  }
}
