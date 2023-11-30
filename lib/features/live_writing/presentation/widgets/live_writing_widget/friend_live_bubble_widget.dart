import 'package:flutter/material.dart';
import 'package:wehavit/features/live_writing/presentation/model/live_writing_state.dart';
import 'package:wehavit/features/live_writing/presentation/widgets/live_writing_widget/friend_live_post_widget.dart';
import 'package:wehavit/features/live_writing/presentation/widgets/live_writing_widget/friend_waiting_bubble_widget.dart';

class FriendLivePostWidget extends StatefulWidget {
  const FriendLivePostWidget({super.key});

  @override
  State<FriendLivePostWidget> createState() => _FriendLivePostWidgetState();
}

class _FriendLivePostWidgetState extends State<FriendLivePostWidget> {
  LiveWritingState writingState = LiveWritingState.ready;
  LiveBubbleState bubbleState = LiveBubbleState.showingDefault;

  final double profileImageRadius = 23;
  final String userName = 'real_buddah';
  final String postTitle = '하루에 한 번 웃기 2일차';
  final String postContent =
      '사리자여... 몇번을 말해야 알아듣느냐... 오늘도 무사히 세번을 참아 냈다. 아재아재 바라아제 바라승아제 모지사바하';
  final ImageProvider userImage = const NetworkImage(
    'https://health.chosun.com/site/data/img_dir/2023/07/17/2023071701753_0.jpg',
  );
  final ImageProvider postImage = const NetworkImage(
    'https://health.chosun.com/site/data/img_dir/2023/07/17/2023071701753_0.jpg',
  );

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: writingState != LiveWritingState.writing,
      replacement: WaitingStateUserBubble(userImage: userImage),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              radius: profileImageRadius,
              foregroundImage: userImage,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: bubbleState == LiveBubbleState.showingDefault ? 47 : null,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return GestureDetector(
                    onTapUp: (details) {
                      setState(() {
                        bubbleState =
                            bubbleState == LiveBubbleState.showingDefault
                                ? LiveBubbleState.showingDetail
                                : LiveBubbleState.showingDefault;
                      });
                    },
                    child: FriendLivePostBubble(
                      userName: userName,
                      postTitle: postTitle,
                      bubbleState: bubbleState,
                      postContent: postContent,
                      postImage: postImage,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
