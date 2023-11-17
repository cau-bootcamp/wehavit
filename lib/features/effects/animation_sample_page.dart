import 'package:flutter/material.dart';
import 'package:wehavit/features/reaction/presentation/widget/reaction_animation_widget.dart';

class AnimationSampleView extends StatelessWidget {
  const AnimationSampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Stack(
          children: [
            ReactionAnimationWidget(),
          ],
        ),
      ),
    );
  }
} 

// class AnimationSampleView extends ConsumerStatefulWidget {
//   const AnimationSampleView({super.key});
//   @override
//   ConsumerState<AnimationSampleView> createState() => _BalloonPageState();
// }

// class _BalloonPageState extends ConsumerState<AnimationSampleView> {
//   late Map<Key, BalloonWidget> _balloonWidgets;
//   late BalloonManager _balloonManager;
//   late Map<Key, TextBubbleFrameWidget> _textBubbleWidgets;
//   late TextBubbleAnimationManager _textBubbleAnimationManager;

//   EmojiFireWorkManager emojiFireWork = EmojiFireWorkManager(
//     emojiAsset: const AssetImage('assets/images/emoji_3d/heart_suit_3d.png'),
//   );

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     _balloonWidgets = ref.watch(balloonManagerProvider);
//     _balloonManager = ref.read(balloonManagerProvider.notifier);

//     _balloonManager.onTapCallbackWithTappedPositionOffset = callBackFunction;

//     _textBubbleWidgets = ref.watch(textBubbleAnimationManagerProvider);
//     _textBubbleAnimationManager =
//         ref.read(textBubbleAnimationManagerProvider.notifier);
//   }

//   @override
//   Widget build(BuildContext context) {
//     _balloonWidgets = ref.watch(balloonManagerProvider);

//     return Scaffold(
//       // extendBodyBehindAppBar: true,
//       appBar: AppBar(title: const Text('Balloon and Emoji Firework')),
//       body: Container(
//         constraints: const BoxConstraints.expand(),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Positioned(
//               top: 100,
//               child: Container(
//                 color: Colors.black26,
//               ),
//             ),
//             Container(
//               constraints: const BoxConstraints.expand(),
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   IgnorePointer(
//                     child: Stack(
//                       children: emojiFireWork.fireworkWidgets.values.toList(),
//                     ),
//                   ),
//                   Stack(
//                     children: _balloonWidgets.values.toList(),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               bottom: 30,
//               child: ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     _balloonManager.addBalloon(
//                       imageUrl:
//                           'https://avatars.githubusercontent.com/u/39216546?v=4',
//                     );
//                   });
//                 },
//                 child: const Text('Tap Button'),
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               child: ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     _textBubbleAnimationManager.addTextBubble(
//                       message: 'hello world!',
//                       imageUrl:
//                           'https://avatars.githubusercontent.com/u/39216546?v=4',
//                     );
//                   });
//                 },
//                 child: const Text("showTextBubble"),
//               ),
//             ),
//             Stack(
//               children: _textBubbleWidgets.values.toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void callBackFunction(Offset offset) {
//     emojiFireWork.addFireworkWidget(offset);
//   }
// }
