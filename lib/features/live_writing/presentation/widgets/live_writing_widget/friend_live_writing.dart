import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wehavit/features/live_writing/domain/repositories/live_writing_friend_repository_provider.dart';

// TODO. 이 파일을 수정하여 친구들의 실시간 글쓰기를 보여주는 위젯을 완성하면 됩니다.
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
    var nameFuture =
        useMemoized(() async => await friendNameFuture(email, ref));
    var messageStream = useMemoized(() => friendMessageStream(email, ref));
    var titleStream = useMemoized(() => friendTitleStream(email, ref));

    var nameSnapshot = useFuture<String>(nameFuture);
    var messageSnapshot = useStream<String>(messageStream);
    var titleSnapshot = useStream<String>(titleStream);
    return Container(
      padding: const EdgeInsets.all(16),
      child: messageSnapshot.hasError
          ? Text(
              '${nameSnapshot.hasData ? nameSnapshot.data : ''}님은 아직 참여하지 않았습니다',
              style:
                  const TextStyle(fontSize: 20).copyWith(color: Colors.brown),
            )
          : messageSnapshot.hasData
              ? Column(
                  children: [
                    Text(
                      '[참여자] ${nameSnapshot.data}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(titleSnapshot.data ?? '',
                        style: const TextStyle(fontSize: 20)),
                    Text(
                      messageSnapshot.data ?? '',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                )
              : const CircularProgressIndicator(),
    );
  }
}
