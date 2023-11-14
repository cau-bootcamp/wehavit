import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/routers/route_location.dart';
import 'package:wehavit/features/live_writing/domain/domain.dart';
import 'package:wehavit/features/live_writing/domain/repositories/friend_repository_provider.dart';
import 'package:wehavit/features/live_writing/presentation/providers/active_resolution_provider.dart';
import 'package:wehavit/features/live_writing/presentation/widgets/widgets.dart';

const liveWritingPageTitle = '실시간 인증 글쓰기';

class LiveWritingPage extends HookConsumerWidget {
  const LiveWritingPage({super.key});

  static LiveWritingPage builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const LiveWritingPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friends = useState(
        ['69dlXoGSBKhzrySuhb8t9MvqzdD3', 'zZaP501Kc8ccUvR9ogPOsjSeD1s2']);

    return Scaffold(
      appBar: AppBar(
        title: const Text(liveWritingPageTitle),
      ),
      body: Stack(
        children: [
          Column(
            children:
                friends.value.map((uid) => FriendWriting(uid: uid)).toList(),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            height: double.infinity,
            width: double.infinity,
            child: const LiveWritingBody(),
          ),
        ],
      ),
    );
  }
}

class FriendWriting extends HookConsumerWidget {
  const FriendWriting({
    super.key,
    required this.uid,
  });

  final String uid;

  Stream<String> friendMessageStream(String uid, WidgetRef ref) {
    return ref.watch(getFriendRepositoryProvider).getFriendMessageByUid(uid);
  }

  Stream<String> friendTitleStream(String uid, WidgetRef ref) {
    return ref.watch(getFriendRepositoryProvider).getFriendTitleByUid(uid);
  }

  Future<String> friendNameFuture(String uid, WidgetRef ref) {
    return ref
        .watch(getFriendRepositoryProvider)
        .getFriendNameByUid(uid)
        .then((value) => value);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var nameFuture = useMemoized(() => friendNameFuture(uid, ref));
    var messageStream = useMemoized(() => friendMessageStream(uid, ref));
    var titleStream = useMemoized(() => friendTitleStream(uid, ref));

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

class LiveWritingBody extends HookConsumerWidget {
  const LiveWritingBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              debugPrint('Empty active resolution list');
              // pop up alert dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('활성화된 목표가 없습니다.'),
                  content: const Text('활성화된 목표가 없습니다.'),
                  actions: [
                    TextButton(
                      onPressed: () => context.go(RouteLocation.home),
                      child: const Text('확인'),
                    ),
                  ],
                ),
              );
            }
          },
        );

        // return loaded page
        return LoadedLiveWritingPage(
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
              (r) => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('인증 완료!')),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
    );
  }
}

class LoadedLiveWritingPage extends StatelessWidget {
  const LoadedLiveWritingPage({
    super.key,
    required this.selectedResolutionGoal,
    required this.activeResolutionList,
    required this.isSubmitted,
    required this.onSubmit,
  });

  final ValueNotifier<String> selectedResolutionGoal;
  final List<String> activeResolutionList;
  final ValueNotifier<bool> isSubmitted;
  final void Function(String title, String content) onSubmit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 250,
            // color: Colors.grey,
            child: Column(
              children: [
                /// Active Goal Dropdown
                ActiveGoalDropdown(
                  isSubmitted: isSubmitted,
                  selectedResolutionGoal: selectedResolutionGoal,
                  activeResolutionList: activeResolutionList,
                ),

                /// Confirm Post Forms
                ConfirmPostForm(
                  isSubmitted: isSubmitted,
                  onSubmit: onSubmit,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
