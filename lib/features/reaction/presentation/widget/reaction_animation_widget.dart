import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/effects/effects.dart';
import 'package:wehavit/features/reaction/presentation/provider/reaction_animation_widget_state_provider.dart';
import 'package:wehavit/features/swipe_view/domain/usecase/swipe_view_usecase.dart';

class ReactionAnimationWidget extends ConsumerStatefulWidget {
  const ReactionAnimationWidget({super.key});

  @override
  ConsumerState<ReactionAnimationWidget> createState() =>
      _ReactionAnimationWidgetState();
}

class _ReactionAnimationWidgetState
    extends ConsumerState<ReactionAnimationWidget> {
  late Map<Key, BalloonWidget> _balloonWidgets;
  late BalloonManager _balloonManager;
  late Map<Key, TextBubbleFrameWidget> _textBubbleWidgets;
  late TextBubbleAnimationManager _textBubbleAnimationManager;

  late List<ReactionGroupModel> _reactionGroupModelList;
  late ReactionAnimationWidgetManager _reactionAnimationWidgetManager;

  late FetchUserDataFromIdUsecase _fetchUserDataFromIdUsecase;

  EmojiFireWorkManager emojiFireWork = EmojiFireWorkManager(
    emojiAsset: const AssetImage('assets/images/emoji_3d/heart_suit_3d.png'),
  );

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

  void addBalloonAnimation({required String imageUrl}) {
    _balloonManager.addBalloon(
      imageUrl: imageUrl,
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
    _textBubbleAnimationManager =
        ref.read(textBubbleAnimationManagerProvider.notifier);

    _reactionAnimationWidgetManager =
        ref.read(reactionAnimationWidgetManagerProvider.notifier);
    _fetchUserDataFromIdUsecase = ref.watch(fetchUserDataFromIdUsecaseProvider);
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
                    children: emojiFireWork.fireworkWidgets.values.toList(),
                  ),
                ),
                Stack(
                  children: _balloonWidgets.values.toList(),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final fetchResult = await _reactionAnimationWidgetManager
                  .getUnreadReactionModelGroupListFromLastConfirmPost();

              for (var reactionGroupModel in fetchResult) {
                final fetchUserModelResult =
                    await _fetchUserDataFromIdUsecase.call(
                  reactionGroupModel.complimenterUid,
                );

                setState(() {
                  final userImageUrl = fetchUserModelResult.fold(
                    (failure) {
                      return 'https://png.pngtree.com/thumb_back/fh260/background/20210409/pngtree-rules-of-biotex-cat-image_600076.jpg';
                    },
                    (userModel) {
                      return userModel.imageUrl;
                    },
                  );
                  addBalloonAnimation(imageUrl: userImageUrl);
                });
              }
            },
            child: const Text('Get Reaction Data'),
          )
        ],
      ),
    );
  }

  void _callBackFunction(Offset offset) {
    emojiFireWork.addFireworkWidget(offset);
  }
}
