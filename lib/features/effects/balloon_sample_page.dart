import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/features/effects/balloon_animation/balloon_manager.dart';
import 'package:wehavit/features/effects/emoji_firework_animation/emoji_firework_manager.dart';

class AnimationSampleView extends ConsumerStatefulWidget {
  const AnimationSampleView({super.key});
  @override
  ConsumerState<AnimationSampleView> createState() => _BalloonPageState();
}

class _BalloonPageState extends ConsumerState<AnimationSampleView> {
  late Map<Key, BalloonWidget> _balloonWidgets;
  late BalloonManager _balloonManager;

  EmojiFireWorkManager emojiFireWork = EmojiFireWorkManager(
    emojiAsset: const AssetImage('assets/images/emoji_3d/heart_suit_3d.png'),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _balloonWidgets = ref.watch(balloonManagerProvider);
    _balloonManager = ref.read(balloonManagerProvider.notifier);
    _balloonManager.onTapCallbackWithTappedPositionOffset = callBackFunction;
  }

  @override
  Widget build(BuildContext context) {
    _balloonWidgets = ref.watch(balloonManagerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Balloon and Emoji Firework")),
      body: Container(
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
                      clipBehavior: Clip.hardEdge,
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
                    _balloonManager.addBalloon(
                        imageUrl:
                            "https://avatars.githubusercontent.com/u/39216546?s=40&v=4");
                  });
                },
                child: const Text("Tap Button"),
              ),
            ),
            Positioned(
              bottom: 0,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text(_balloonWidgets.length.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void callBackFunction(Offset offset) {
    emojiFireWork.addFireworkWidget(offset);
  }
}
