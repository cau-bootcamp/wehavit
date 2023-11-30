import 'package:flutter/material.dart';

class LiveWritingView extends StatelessWidget {
  const LiveWritingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16.0),
        child: Column(
          children: List<Widget>.generate(
            4,
            (index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: FriendLiveBubbleWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

class FriendLiveBubbleWidget extends StatefulWidget {
  const FriendLiveBubbleWidget({super.key});

  @override
  State<FriendLiveBubbleWidget> createState() => _FriendLiveBubbleWidgetState();
}

class _FriendLiveBubbleWidgetState extends State<FriendLiveBubbleWidget> {
  LiveWritingState writingState = LiveWritingState.ready;
  LiveBubbleState bubbleState = LiveBubbleState.showingDefault;

  final double profileImageRadius = 23;
  final String userName = 'real_buddah';
  final String postTitle = '하루에 한 번 웃기 2일차';
  final String postContent =
      '사리자여... 몇번을 말해야 알아듣느냐... 오늘도 무사히 세번을 참아 냈다. 아재아재 바라아제 바라승아제 모지사바하';
  final ImageProvider userImage = NetworkImage(
    'https://health.chosun.com/site/data/img_dir/2023/07/17/2023071701753_0.jpg',
  );
  final ImageProvider postImage = NetworkImage(
    'https://health.chosun.com/site/data/img_dir/2023/07/17/2023071701753_0.jpg',
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Visibility(
        visible: writingState != LiveWritingState.writing,
        replacement: WaitingStateUserBubble(userImage: userImage),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: profileImageRadius,
                foregroundImage: userImage,
              ),
            ),
            Expanded(
              child: Container(
                height:
                    bubbleState == LiveBubbleState.showingDefault ? 47 : null,
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
                      child: LiveUserBubble(
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
      ),
    );
  }
}

class LiveUserBubble extends StatelessWidget {
  const LiveUserBubble({
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

class WaitingStateUserBubble extends StatelessWidget {
  const WaitingStateUserBubble({
    super.key,
    required this.userImage,
  });

  final ImageProvider<Object> userImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              radius: 35,
              foregroundImage: userImage,
            ),
          ),
          Positioned(
            left: 46,
            bottom: 50,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xaa8C8C8C),
                borderRadius: BorderRadius.circular(50.0),
              ),
              width: 77,
              height: 35,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (_) => Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        width: 8,
                        height: 8,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum LiveWritingState { ready, writing, done }

enum LiveBubbleState {
  showingDefault,
  showingDetail,
}
