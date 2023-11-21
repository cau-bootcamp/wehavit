import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wehavit/features/live_writing/domain/repositories/live_writing_friend_repository_provider.dart';
import 'package:wehavit/features/swipe_view/domain/model/reaction_model.dart';

class FriendLiveWriting extends HookConsumerWidget {
  const FriendLiveWriting({
    super.key,
    required this.email,
  });

  final String email;

  Future<String> friendNameFuture(String email, WidgetRef ref) {
    return ref
        .read(liveWritingFriendRepositoryProvider)
        .getFriendNameOnceByEmail(email);
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameFuture =
        useMemoized(() async => await friendNameFuture(email, ref));
    final messageStream = useMemoized(() => friendMessageStream(email, ref));
    final titleStream = useMemoized(() => friendTitleStream(email, ref));

    final nameSnapshot = useFuture<String>(nameFuture);
    final messageSnapshot = useStream<String>(messageStream);
    final titleSnapshot = useStream<String>(titleStream);

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(2),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(0)),
      ),
      child: messageSnapshot.hasError
          ? Text(
              '${nameSnapshot.hasData ? nameSnapshot.data : ''}님은 아직 참여하지 않았습니다',
              style:
                  const TextStyle(fontSize: 10).copyWith(color: Colors.brown),
            )
          : messageSnapshot.hasData
              ? Column(
                  children: [
                    Text(
                      '[참여자] ${nameSnapshot.data}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      titleSnapshot.data ?? '',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      messageSnapshot.data ?? '',
                      style: const TextStyle(fontSize: 10),
                    ),
                    SendEncourageButtons(email: email),
                  ],
                )
              : const CircularProgressIndicator(),
    );
  }
}

class SendEncourageButtons extends HookConsumerWidget {
  const SendEncourageButtons({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SendInstantPhotoButton(email: email),
        SendEmojiButton(email: email),
        SendTextButton(email: email),
      ],
    );
  }
}

class SendInstantPhotoButton extends HookConsumerWidget {
  const SendInstantPhotoButton({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        // TODO. 스냅샷 응원을 전송하는 로직을 완성하면 됩니다.
        final sendResult = await ref
            .read(liveWritingFriendRepositoryProvider)
            .sendReactionToTargetFriend(
              email,
              ReactionModel(
                complimenterUid: '',
                reactionType: ReactionType.instantPhoto.index,
                instantPhotoUrl: 'https://picsum.photos/200/300',
              ),
            );
        sendResult.fold(
          (l) => debugPrint('send photo to $email failed'),
          (r) => debugPrint('send photo to $email success'),
        );
      },
      child: const Text('스냅샷', style: TextStyle(fontSize: 12)),
    );
  }
}

class SendEmojiButton extends HookConsumerWidget {
  const SendEmojiButton({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        // TODO. 이모지 응원을 전송하는 로직을 완성하면 됩니다.
        final sendResult = await ref
            .read(liveWritingFriendRepositoryProvider)
            .sendReactionToTargetFriend(
              email,
              ReactionModel(
                complimenterUid: '',
                reactionType: ReactionType.emoji.index,
                emoji: {'👍': 1, '👎': 2},
              ),
            );
        sendResult.fold(
          (l) => debugPrint('send emoji to $email failed'),
          (r) => debugPrint('send emoji to $email success'),
        );
      },
      child: const Text('이모지', style: TextStyle(fontSize: 12)),
    );
  }
}

class SendTextButton extends HookConsumerWidget {
  const SendTextButton({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dialogTextController = useTextEditingController();
    return ElevatedButton(
      onPressed: () async {
        // Show Post Content Input Dialog
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('인증글'),
              content: TextFormField(
                minLines: 3,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                style: const TextStyle(
                  fontSize: 10,
                ),
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(0),
                    ),
                  ),
                  filled: true,
                ),
                controller: dialogTextController,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('취소'),
                ),
                TextButton(
                  onPressed: () async {
                    // TODO. 텍스트 응원을 전송하는 로직을 완성하면 됩니다.
                    final sendResult = ref
                        .read(liveWritingFriendRepositoryProvider)
                        .sendReactionToTargetFriend(
                          email,
                          ReactionModel(
                            complimenterUid: '',
                            reactionType: ReactionType.comment.index,
                            comment: dialogTextController.text,
                          ),
                        );

                    sendResult.then(
                      (value) => {
                        value.fold(
                          (l) => debugPrint('send text to $email failed'),
                          (r) => debugPrint('send text to $email success'),
                        ),
                      },
                    );

                    dialogTextController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('확인'),
                ),
              ],
            );
          },
        );
      },
      child: const Text('텍스트', style: TextStyle(fontSize: 12)),
    );
  }
}
