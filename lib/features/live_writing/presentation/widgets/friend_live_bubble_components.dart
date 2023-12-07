import 'package:flutter/material.dart';
import 'package:wehavit/common/constants/app_colors.dart';
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
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: CustomColors.whYellow,
      ),
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
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: CustomColors.whWhite,
      ),
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
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          // boxShadow: [
          //   BoxShadow(
          //       color: Colors.black26,
          //       spreadRadius: 2,
          //       blurRadius: 2,
          //       offset: Offset(0, 2))
          // ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Image(
            width: 50,
            height: 37,
            fit: BoxFit.fill,
            image: postImage,
            errorBuilder: (context, error, stackTrace) {
              return const Image(
                width: 50,
                height: 37,
                fit: BoxFit.cover,
                image: NetworkImage(
                  // TODO: 이미지가 유효하지 않은 경우에 넣어줄 placeholder 지정해주기
                  // dummy image
                  'https://i2.ruliweb.com/img/19/08/30/16cde8040044c8ac6.png',
                ),
              );
            }),
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

  final double detailImageWidth = 133;
  final double detailImageHeight = 84;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: bubbleState == LiveBubbleState.showingDetail,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: detailImageHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  postContent,
                  textAlign: TextAlign.start,
                  maxLines: 5,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: CustomColors.whWhite,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Visibility(
            visible: bubbleState != LiveBubbleState.showingDefault,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Image(
                width: detailImageWidth,
                height: detailImageHeight,
                fit: BoxFit.cover,
                image: postImage,
                errorBuilder: (context, error, stackTrace) {
                  return Image(
                    width: detailImageWidth,
                    height: detailImageHeight,
                    fit: BoxFit.cover,
                    image: const NetworkImage(
                      // TODO: 이미지가 유효하지 않은 경우에 넣어줄 placeholder 지정해주기
                      // dummy Image
                      'https://i2.ruliweb.com/img/19/08/30/16cde8040044c8ac6.png',
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
