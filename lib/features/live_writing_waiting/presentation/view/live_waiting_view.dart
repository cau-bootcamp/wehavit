import 'package:flutter/material.dart';
import 'package:wehavit/features/live_writing_waiting/presentation/view/live_waiting_avatar_animation_widget.dart';

class LiveWritingView extends StatefulWidget {
  const LiveWritingView({super.key});

  @override
  State<LiveWritingView> createState() => _LiveWritingViewState();
}

class _LiveWritingViewState extends State<LiveWritingView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      alignment: Alignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            LiveWaitingAvatarAnimatingWidget(),
            LiveWaitingAvatarAnimatingWidget(),
            LiveWaitingAvatarAnimatingWidget(),
            LiveWaitingAvatarAnimatingWidget(),
            LiveWaitingAvatarAnimatingWidget(),
          ],
        ),
        Positioned(
            top: 100,
            child: Column(
              children: [
                Text(
                  "곧 뭐시기를 시작합니다",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "입장 중",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "00:00",
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ))
      ],
    ));
  }
}
