import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/live_writing/live_writing.dart';

const liveWritingPageTitle = '실시간 인증 글쓰기';

class LiveWritingPage extends HookConsumerWidget {
  const LiveWritingPage({super.key});

  static LiveWritingPage builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const LiveWritingPage();

  Future<List<String>> getVisibleFriends(WidgetRef ref) {
    return ref
        .read(liveWritingFriendRepositoryProvider)
        .getVisibleFriendEmailList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var friendEmailsFuture = useMemoized(() => getVisibleFriends(ref));
    var friendEmailsSnapshot = useFuture<List<String>>(friendEmailsFuture);

    return Scaffold(
      appBar: AppBar(
        title: const Text(liveWritingPageTitle),
      ),
      body: Stack(
        children: [
          Column(
            children: friendEmailsSnapshot.hasData
                ? friendEmailsSnapshot.data!
                    .map((email) => FriendLiveWriting(email: email))
                    .toList()
                : [],
          ),
          Container(
            padding: const EdgeInsets.all(16),
            height: double.infinity,
            width: double.infinity,
            child: const MyLiveWritingBody(),
          ),
        ],
      ),
    );
  }
}

class MyLiveWritingBody extends HookConsumerWidget {
  const MyLiveWritingBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO. useState 대신 riverpod의 stateProvider 사용하도록 통일하기
    final isSubmitted = useState(false);
    final selectedResolutionGoal = useState('');
    final activeResolutionList = ref.watch(activeResolutionListProvider);

    return activeResolutionList.when(
      data: (fetchedActiveResolutionList) {
        // load first goal statement
        fetchedActiveResolutionList.fold(
          (error) =>
              debugPrint('Error, when fetching active resolution list: $error'),
          (resolutionList) async {
            if (resolutionList.isNotEmpty) {
              selectedResolutionGoal.value = resolutionList.first.goalStatement;
            } else {
              showNoResolutionDiagram(context, '활성화된 목표가 없습니다. 목표를 추가해주세요.');
            }
          },
        );

        // 로딩 완료되면 표시될 위젯
        return MyLiveWriting(
          selectedResolutionGoal: selectedResolutionGoal,
          activeResolutionList: fetchedActiveResolutionList.fold(
            (error) => [],
            (resolutionList) => resolutionList
                .map((resolution) => resolution.goalStatement)
                .toList(),
          ),
          isSubmitted: isSubmitted,
          onSubmit: (String title, String content) async {
            isSubmitted.value = true;
            ConfirmPostModel cf = ConfirmPostModel(
              title: title,
              content: content,
              resolutionGoalStatement: selectedResolutionGoal.value,
              resolutionId: null,
              imageUrl: '',
              recentStrike: 0,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              owner: '',
              fan: [],
              attributes: {
                'has_participated_live': true,
                'has_rested': false,
              },
            );

            (await ref.read(createPostUseCaseProvider)(cf)).fold(
              (l) {
                debugPrint(Failure(l.message).toString());
              },
              (r) => showSimpleSnackBar(context, '인증글이 등록되었습니다'),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSimpleSnackBar(
    BuildContext context,
    String message,
  ) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> showNoResolutionDiagram(
    BuildContext context,
    String alertMessage,
  ) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(alertMessage),
        content: Text(alertMessage),
        actions: [
          TextButton(
            onPressed: () => context.go(RouteLocation.addResolution),
            child: const Text('목표 추가하러 가기'),
          ),
        ],
      ),
    );
  }
}
