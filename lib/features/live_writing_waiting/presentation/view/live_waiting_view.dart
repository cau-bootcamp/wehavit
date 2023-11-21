import 'package:flutter/material.dart';
import 'package:wehavit/features/live_writing_waiting/presentation/view/widget/live_waiting_avatar_animation_widget.dart';

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
            children: List.generate(
              5,
              (_) => LiveWaitingAvatarAnimatingWidget(
                userImageUrl:
                    "https://mblogthumb-phinf.pstatic.net/MjAyMDA0MDlfMzgg/MDAxNTg2NDEyNjMwNTU2.tj79WwOeb17w8C0PQWXqebTyUyTT6pfCNVOoCSzBOaIg.8vfG4lXr0u-LZdHOoWGUSIKzsXwoa5zGuYkdrwqu1vcg.PNG.klipk2/먼지1.png?type=w800",
              ),
            ),
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
                      color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "입장 중",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Text(
                  "00:00",
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
