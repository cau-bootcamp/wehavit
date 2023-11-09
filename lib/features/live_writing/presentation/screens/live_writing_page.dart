import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wehavit/features/live_writing/domain/domain.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(liveWritingPageTitle),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: const LiveWritingBody(),
      ),
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
          (resolutionList) {
            if (resolutionList.isNotEmpty) {
              selectedResolutionGoal.value = resolutionList.first.goalStatement;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('주의! 활성화된 목표가 없습니다.')),
              );
              debugPrint('Empty active resolution list');
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
              roles: {},
              attributes: {
                'has_participated_live': true,
                'has_rested': false,
              },
            );

            await ref.read(confirmPostRepositoryProvider).createConfirmPost(cf);
          },
        );
      },
      loading: () => const Center(child: Text('Loading')),
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
