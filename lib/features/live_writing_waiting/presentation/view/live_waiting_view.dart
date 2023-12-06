// ignore_for_file: discarded_futures

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wehavit/common/routers/route_location.dart';
import 'package:wehavit/features/live_writing_waiting/domain/models/counter_state.dart';
import 'package:wehavit/features/live_writing_waiting/domain/models/waiting_model.dart';
import 'package:wehavit/features/live_writing_waiting/domain/models/waiting_user_model.dart';
import 'package:wehavit/features/live_writing_waiting/domain/repositories/live_waiting_repository_provider.dart';
import 'package:wehavit/features/live_writing_waiting/presentation/view/widget/live_waiting_avatar_animation_widget.dart';

// 다른 유저들이 기다리고 있는지 polling하는 주기
const syncDelay = Duration(seconds: 5);
// stream that loops on every {sycnDelay} duration
Stream getSyncLiveStream(WidgetRef ref) {
  final syncLiveStream = Stream.periodic(syncDelay, (_) {
    return ref.read(liveWaitingRepositoryProvider).syncLiveWaitingUserStatus(
          DateTime.now(),
        );
  }).asyncMap((event) async => await event);

  return syncLiveStream;
}

class LiveWritingView extends HookConsumerWidget {
  const LiveWritingView({super.key});

  final String enteringTitle = '곧 입장을 시작합니다!';
  final String enteringDescription = '입장중...';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Timer Countdown Stream
    final timerStream =
        useMemoized(() => ref.read(waitingProvider.notifier).getTimerStream());
    final timerStreamSnapshot = useStream(timerStream);

    // Syncing Online Status
    final liveStream = useMemoized(
      () => getSyncLiveStream(ref),
    );
    useStream(liveStream);

    // Get Waiting User Stream Future
    final liveWaitingUserStreamFuture = useMemoized(
      () => ref.read(liveWaitingRepositoryProvider).getLiveWaitingUsersStream(),
    );
    final liveWaitingUserStreamSnapshot =
        useFuture(liveWaitingUserStreamFuture);

    // Waiting or Writing State
    final waitingState = ref.watch(waitingProvider);
    if (waitingState.counterStateEnum == CounterStateEnum.timeForWriting) {
      context.go(RouteLocation.liveWriting);
    }

    return liveWaitingUserStreamSnapshot.hasData
        ? LoadedWaitingView(
            enteringTitle: enteringTitle,
            enteringDescription: enteringDescription,
            timerStreamSnapshot: timerStreamSnapshot,
            liveWaitingUserStreamSnapshotData:
                liveWaitingUserStreamSnapshot.data!,
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}

class LoadedWaitingView extends HookConsumerWidget {
  const LoadedWaitingView({
    super.key,
    required this.enteringTitle,
    required this.enteringDescription,
    required this.timerStreamSnapshot,
    required this.liveWaitingUserStreamSnapshotData,
  });

  final String enteringTitle;
  final String enteringDescription;
  final AsyncSnapshot<String> timerStreamSnapshot;
  final Stream<List<WaitingUser>> liveWaitingUserStreamSnapshotData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Waiting Users Stream
    final liveWaitingUsersStream = useMemoized(
      () => liveWaitingUserStreamSnapshotData,
    );
    final liveWaitingUsersStreamSnapshot = useStream<List<WaitingUser>>(
      liveWaitingUsersStream,
    );

    // 5초 이내에 업데이트 된 유저들만 필터링
    final liveWaitingUsers = (liveWaitingUsersStreamSnapshot.data ?? [])
        .where(
          (e) => e.updatedAt!.isAfter(
            DateTime.now().subtract(
              const Duration(seconds: 5),
            ),
          ),
        )
        .toList();

    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: List.generate(
              liveWaitingUsers.length,
              (idx) => LiveWaitingAvatarAnimatingWidget(
                userImageUrl: liveWaitingUsers[idx].imageUrl!,
              ),
            ),
          ),
          Positioned(
            top: 100,
            child: Column(
              children: [
                Text(
                  enteringTitle,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  enteringDescription,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${timerStreamSnapshot.data}',
                  style: const TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                liveWaitingUsersStreamSnapshot.hasData
                    ? liveWaitingUsersStreamSnapshot.data!.isEmpty
                        ? const Text('🥵누구도 기다리고 있지 않습니다.')
                        : Column(
                            children: liveWaitingUsers
                                .map(
                                  (e) => Text(
                                    '😃${e.email}님이 기다리고 있습니다.'
                                    '\n ${e.updatedAt}',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                                .toList(),
                          )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
