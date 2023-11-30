import 'package:flutter/material.dart';
import 'package:wehavit/features/live_writing/presentation/model/live_writing_state.dart';
import 'package:wehavit/features/live_writing/presentation/screens/live_writing_view.dart';
import 'package:wehavit/features/live_writing/presentation/widgets/live_writing_widget/friend_live_bubble_components.dart';

class FriendLivePostBubble extends StatelessWidget {
  const FriendLivePostBubble({
    super.key,
    required this.userName,
    required this.postTitle,
    required this.bubbleState,
    required this.postContent,
    required this.postImage,
  });

  final String userName;
  final String postTitle;
  final LiveBubbleState bubbleState;
  final String postContent;
  final ImageProvider<Object> postImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        constraints: const BoxConstraints(minWidth: 120),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PostTitleWidget(userName: userName),
                              PostContentWidget(postTitle: postTitle),
                              PostImageWidgetForDefault(
                                bubbleState: bubbleState,
                                postContent: postContent,
                                postImage: postImage,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    PostWidgetImageForDetail(
                      bubbleState: bubbleState,
                      postImage: postImage,
                    ),
                  ],
                ),
                // TODO : 반응 남기기 기능 개발
                Visibility(
                  visible: bubbleState == LiveBubbleState.showingDetail,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List<Widget>.generate(
                      6,
                      (index) => const Placeholder(
                        fallbackWidth: 40,
                        fallbackHeight: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
