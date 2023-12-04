import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wehavit/common/utils/emoji_assets.dart';
import 'package:wehavit/features/live_writing/presentation/model/live_writing_state.dart';
import 'package:wehavit/features/live_writing/presentation/widgets/friend_live_bubble_components.dart';

class FriendLiveBubbleWidget extends StatefulHookConsumerWidget {
  const FriendLiveBubbleWidget({
    super.key,
    required this.userName,
    required this.postTitle,
    required this.bubbleState,
    required this.postContent,
    required this.postImageFirestoreURL,
    required this.emojiSendCallback,
  });

  final String userName;
  final String postTitle;
  final LiveBubbleState bubbleState;
  final String postContent;
  final String postImageFirestoreURL;
  final Function emojiSendCallback;

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
                                postImage:
                                    NetworkImage(widget.postImageFirestoreURL),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    PostWidgetImageForDetail(
                      bubbleState: widget.bubbleState,
                      postImage: NetworkImage(widget.postImageFirestoreURL),
                    ),
                  ],
                ),
                // TODO : 반응 남기기 기능 개발
                Visibility(
                  visible: widget.bubbleState == LiveBubbleState.showingDetail,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List<Widget>.generate(
                        6,
                        (index) => InkWell(
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Image(
                              image: AssetImage(
                                Emojis.emojiList[index],
                              ),
                            ),
                          ),
                          onTap: () async {
                            widget.emojiSendCallback(index);
                          },
                        ),
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
