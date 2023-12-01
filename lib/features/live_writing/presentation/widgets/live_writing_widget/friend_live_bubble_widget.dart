import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wehavit/features/live_writing/presentation/model/live_writing_state.dart';
import 'package:wehavit/features/live_writing/presentation/widgets/live_writing_widget/friend_live_bubble_components.dart';

class FriendLiveBubbleWidget extends StatefulHookConsumerWidget {
  const FriendLiveBubbleWidget({
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
  ConsumerState<FriendLiveBubbleWidget> createState() =>
      _FriendLivePostBubbleState();
}

class _FriendLivePostBubbleState extends ConsumerState<FriendLiveBubbleWidget> {
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
                              PostTitleWidget(userName: widget.userName),
                              PostContentWidget(postTitle: widget.postTitle),
                              PostImageWidgetForDefault(
                                bubbleState: widget.bubbleState,
                                postContent: widget.postContent,
                                postImage: widget.postImage,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    PostWidgetImageForDetail(
                      bubbleState: widget.bubbleState,
                      postImage: widget.postImage,
                    ),
                  ],
                ),
                // TODO : 반응 남기기 기능 개발
                Visibility(
                  visible: widget.bubbleState == LiveBubbleState.showingDetail,
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
