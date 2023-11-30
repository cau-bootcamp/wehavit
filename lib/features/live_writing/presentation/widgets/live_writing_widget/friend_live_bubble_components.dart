import 'package:flutter/material.dart';
import 'package:wehavit/features/live_writing/presentation/model/live_writing_state.dart';

class PostContentWidget extends StatelessWidget {
  const PostContentWidget({
    super.key,
    required this.postTitle,
  });

  final String postTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      postTitle,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}

class PostTitleWidget extends StatelessWidget {
  const PostTitleWidget({
    super.key,
    required this.userName,
  });

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Text(
      userName,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}

class PostWidgetImageForDetail extends StatelessWidget {
  const PostWidgetImageForDetail({
    super.key,
    required this.bubbleState,
    required this.postImage,
  });

  final LiveBubbleState bubbleState;
  final ImageProvider<Object> postImage;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: bubbleState == LiveBubbleState.showingDefault,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 2))
            ]),
        clipBehavior: Clip.hardEdge,
        child: Image(
          width: 50,
          height: 37,
          fit: BoxFit.fill,
          image: postImage,
        ),
      ),
    );
  }
}

class PostImageWidgetForDefault extends StatelessWidget {
  const PostImageWidgetForDefault({
    super.key,
    required this.bubbleState,
    required this.postContent,
    required this.postImage,
  });

  final LiveBubbleState bubbleState;
  final String postContent;
  final ImageProvider<Object> postImage;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: bubbleState == LiveBubbleState.showingDetail,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                postContent,
              ),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Visibility(
            visible: bubbleState != LiveBubbleState.showingDefault,
            child: Image(
                width: 113, height: 84, fit: BoxFit.fill, image: postImage),
          ),
        ],
      ),
    );
  }
}
