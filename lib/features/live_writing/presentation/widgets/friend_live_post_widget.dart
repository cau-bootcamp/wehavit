import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wehavit/common/constants/app_colors.dart';
import 'package:wehavit/features/live_writing/domain/domain.dart';
import 'package:wehavit/features/live_writing/presentation/model/live_writing_state.dart';
import 'package:wehavit/features/live_writing/presentation/widgets/friend_live_bubble_widget.dart';
import 'package:wehavit/features/live_writing/presentation/widgets/friend_waiting_bubble_widget.dart';

import 'package:wehavit/features/swipe_view/domain/model/reaction_model.dart';

class FriendLivePostWidget extends StatefulHookConsumerWidget {
  const FriendLivePostWidget({
    super.key,
    required this.sendReactionCallback,
    required this.userEmail,
  });
  final String userEmail;
  final Function sendReactionCallback;

  @override
  ConsumerState<FriendLivePostWidget> createState() =>
      _FriendLivePostWidgetState();
}

class _FriendLivePostWidgetState extends ConsumerState<FriendLivePostWidget> {
  LiveWritingState writingState = LiveWritingState.ready;
  LiveBubbleState bubbleState = LiveBubbleState.showingDefault;

  Future<String> friendNameFuture(String email, WidgetRef ref) {
    return ref
        .read(liveWritingFriendRepositoryProvider)
        .getFriendNameOnceByEmail(email);
  }

  Future<String> friendProfileImageUrlFuture(String email, WidgetRef ref) {
    return ref
        .read(liveWritingFriendRepositoryProvider)
        .getFriendProfileImageUrlByEmail(email);
  }

  Stream<String> friendMessageStream(String email, WidgetRef ref) {
    return ref
        .watch(liveWritingFriendRepositoryProvider)
        .getFriendMessageLiveByEmail(email);
  }

  Stream<String> friendTitleStream(String email, WidgetRef ref) {
    return ref
        .watch(liveWritingFriendRepositoryProvider)
        .getFriendTitleLiveByEmail(email);
  }

  Stream<String> friendPostImageStream(String email, WidgetRef ref) {
    return ref
        .watch(liveWritingFriendRepositoryProvider)
        .getFriendPostImageLiveByEmail(email);
  }

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
    final nameFuture =
        // ignore: discarded_futures
        useMemoized(() async => await friendNameFuture(widget.userEmail, ref));
    // ignore: discarded_futures
    final profileImageUrlFuture = useMemoized(
        () async => await friendProfileImageUrlFuture(widget.userEmail, ref));

    final messageStream =
        useMemoized(() => friendMessageStream(widget.userEmail, ref));
    final titleStream =
        useMemoized(() => friendTitleStream(widget.userEmail, ref));
    final postImageStream =
        useMemoized(() => friendPostImageStream(widget.userEmail, ref));

    final nameSnapshot = useFuture<String>(nameFuture);
    final profileImageUrlSnapshot = useFuture<String>(profileImageUrlFuture);
    final titleSnapshot = useStream<String>(titleStream);
    final messageSnapshot = useStream<String>(messageStream);
    final postImageSnapshot = useStream<String>(postImageStream);

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
              backgroundColor: CustomColors.whYellowDark,
              radius: profileImageRadius,
              foregroundImage: NetworkImage(
                profileImageUrlSnapshot.data ??
                    'https://mblogthumb-phinf.pstatic.net/MjAyMjAxMjVfNTgg/MDAxNjQzMTAyOTg1MTk1.kvD7eFVnAbMS2LREsFqsYfsw4hnJDFuGUfBUX2kUKikg.jr9qYJbmDH9AmJPHbJcM9FrhpOnOaYp5qAVk8nF9vR4g.JPEG.minziminzi128/IMG_7365.JPG?type=w800',
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: bubbleState == LiveBubbleState.showingDefault ? 50 : null,
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
                    child: FriendLiveBubbleWidget(
                      userName: nameSnapshot.data ?? '이름',
                      postTitle: titleSnapshot.data ?? '제목을 불러오는 중',
                      postContent: messageSnapshot.data ?? '내용을 불러오는 중',
                      postImageFirestoreURL: postImageSnapshot.data == '' ||
                              postImageSnapshot.data == null
                          ? 'https://mblogthumb-phinf.pstatic.net/MjAyMjAxMjVfNTgg/MDAxNjQzMTAyOTg1MTk1.kvD7eFVnAbMS2LREsFqsYfsw4hnJDFuGUfBUX2kUKikg.jr9qYJbmDH9AmJPHbJcM9FrhpOnOaYp5qAVk8nF9vR4g.JPEG.minziminzi128/IMG_7365.JPG?type=w800'
                          : postImageSnapshot.data!,
                      bubbleState: bubbleState,
                      userEmail: widget.userEmail,
                      emojiSendCallback: widget.sendReactionCallback,
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
