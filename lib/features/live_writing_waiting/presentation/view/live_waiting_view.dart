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

/// ## 사용 방법
/// 1. Provider를 ref로 read 해준 뒤
/// ```
///   late LiveWaitingViewUserImageUrlList _imageUrlListProvider;
///   _imageUrlListProvider = ref.read(liveWaitingViewUserImageUrlListProvider.notifier);
/// ```
/// 2. LiveWritingView를 Stack에 담아주고
/// ```
/// Stack(
///   children: [ ... ,
///     LiveWritingView()
///   ...
///   ]
/// )
///
/// ```
/// 3. 아래처럼 urlString을 추가하는 함수를 호출해 화면에 버블을 그리거나 제거할 수 있음
/// ```
///   // 추가
///   _imageUrlListProvider.addUserImageUrl(imageUrl: 'urlString');
///   // 제거
///   _imageUrlListProvider.removeUserImageUrl(imageUrl: 'urlString');
/// ```

class LiveWritingView extends StatefulHookConsumerWidget {
  const LiveWritingView({super.key});

  @override
  ConsumerState<LiveWritingView> createState() => _LiveWritingViewState();
}

class _LiveWritingViewState extends ConsumerState<LiveWritingView> {
  late List<String> _liveWaitingViewUserImageUrlList;

  final String enteringTitle = '곧 입장을 시작합니다!';
  final String enteringDescription = '입장중...';

  @override
  Widget build(BuildContext context) {
    _liveWaitingViewUserImageUrlList =
        ref.watch(liveWaitingViewUserImageUrlListProvider);
    final waitingState = ref.watch(waitingProvider);

    // Timer Countdown Stream
    final timerStream =
        useMemoized(() => ref.read(waitingProvider.notifier).getTimerStream());
    final timerStreamSnapshot = useStream<String>(timerStream);

    // Syncing Online Status
    final liveStream = useMemoized(
      () => getSyncLiveStream(ref),
    );
    final liveStreamSnapshot = useStream<Future<String>>(liveStream);

    // Get Waiting User Stream Future
    final liveWaitingUserStreamFuture = useMemoized(
      () => ref.read(liveWaitingRepositoryProvider).getLiveWaitingUsersStream(),
    );
    final liveWaitingUserStreamSnapshot =
        useFuture(liveWaitingUserStreamFuture);

    if (waitingState.counterStateEnum == CounterStateEnum.timeForWriting) {
      context.go(RouteLocation.liveWriting);
    }

    return liveWaitingUserStreamSnapshot.hasData
        ? LoadedWaitingView(
            liveWaitingViewUserImageUrlList: _liveWaitingViewUserImageUrlList,
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
    required List<String> liveWaitingViewUserImageUrlList,
    required this.enteringTitle,
    required this.enteringDescription,
    required this.timerStreamSnapshot,
    required this.liveWaitingUserStreamSnapshotData,
  }) : _liveWaitingViewUserImageUrlList = liveWaitingViewUserImageUrlList;

  final List<String> _liveWaitingViewUserImageUrlList;
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

    useEffect(
      () {
        // debugPrint(
        //     'UseEffect LIVE_USERS: ${liveWaitingUsersStreamSnapshot.data.toString()}');

        return () {};
      },
      [liveWaitingUsersStreamSnapshot],
    );

    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: List.generate(
              _liveWaitingViewUserImageUrlList.length,
              (idx) => LiveWaitingAvatarAnimatingWidget(
                userImageUrl: _liveWaitingViewUserImageUrlList[idx],
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
                        ? const Text('누구도 기다리고 있지 않습니다.')
                        : Column(
                            children: liveWaitingUsersStreamSnapshot.data!
                                .map(
                                  (e) => Text(
                                    '${e.email}님이 기다리고 있습니다.',
                                    style: const TextStyle(
                                      fontSize: 20,
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

final liveWaitingViewUserImageUrlListProvider =
    StateNotifierProvider<LiveWaitingViewUserImageUrlList, List<String>>(
  (ref) => LiveWaitingViewUserImageUrlList(),
);

class LiveWaitingViewUserImageUrlList extends StateNotifier<List<String>> {
  LiveWaitingViewUserImageUrlList() : super([]);

  void addUserImageUrl({required String imageUrl}) {
    state = List.from(state..add(imageUrl));
    // state = state..append(imageUrl);
  }

  void removeUserImageUrl({required String imageUrl}) {
    state = state..remove(imageUrl);
  }
}

// stream that loops every 10 seconds
Stream<Future<String>> getSyncLiveStream(WidgetRef ref) {
  final syncLiveStream = Stream.periodic(
    const Duration(seconds: 5),
    (count) async {
      final result = await ref
          .read(liveWaitingRepositoryProvider)
          .syncLiveWaitingUserStatus(
            DateTime.now(),
          );

      // debugPrint('syncLiveStream($count): $result');

      return count.toString();
    },
  );

  return syncLiveStream;
}
