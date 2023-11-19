import 'package:flutter/material.dart';
import 'package:wehavit/features/reaction/presentation/widget/reaction_animation_widget.dart';

class AnimationSamplePage extends StatelessWidget {
  const AnimationSamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          // 메인 뷰를 요렇게 넣어주면 됩니다!
          Container(),
          const ReactionAnimationWidget(),
        ],
      ),
    );
  }
}
