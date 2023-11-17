import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/effects/effects.dart';

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
          Positioned(
            bottom: 30,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  addBalloonAnimation(
                    imageUrl:
                        'https://avatars.githubusercontent.com/u/39216546?v=4',
                  );
                });
              },
              child: const Text('Tap Button'),
            ),
          ),
          Positioned(
            bottom: 0,
            child: ElevatedButton(
              onPressed: () {
                addTextBubbleAnimation(
                  message: 'HELLO',
                  imageUrl:
                      'https://avatars.githubusercontent.com/u/39216546?v=4',
                );
              },
              child: const Text('showTextBubble'),
            ),
          ),
          Stack(
            children: _textBubbleWidgets.values.toList(),
          ),
        ],
      ),
    );
  }

  void _callBackFunction(Offset offset) {
    emojiFireWork.addFireworkWidget(offset);
  }
}
