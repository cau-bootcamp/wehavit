import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wehavit/common/routers/route_location.dart';
import 'package:wehavit/features/live_writing_waiting/domain/models/counter_state.dart';
import 'package:wehavit/features/live_writing_waiting/domain/models/waiting_model.dart';
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
    final waitingState = ref.watch(waitingProvider);
    final stream =
        useMemoized(() => ref.read(waitingProvider.notifier).getTimerStream());
    final snapshot = useStream<String>(stream);
    _liveWaitingViewUserImageUrlList =
        ref.watch(liveWaitingViewUserImageUrlListProvider);

    if (waitingState.counterStateEnum == CounterStateEnum.timeForWriting) {
      context.go(RouteLocation.liveWriting);
    }

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
                  '${snapshot.data}',
                  style: const TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
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
