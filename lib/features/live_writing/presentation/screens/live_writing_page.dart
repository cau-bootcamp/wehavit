import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wehavit/features/live_writing/data/datasources/confirm_post_remote_datasource_impl.dart';
import 'package:wehavit/features/live_writing/presentation/widgets/confirm_post_from.dart';
import 'package:wehavit/features/live_writing/presentation/widgets/user_active_goal_dropdown.dart';

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
        title: const Text('실시간 인증 글쓰기'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: LiveWritingBody(),
      ),
    );
  }
}

class LiveWritingBody extends HookConsumerWidget {
  const LiveWritingBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSubmitted = useState(false);
    final userInput = useState('');
    final resolutionGoal = useState('');

    void onUserInput(String input) {
      userInput.value = input;
      isSubmitted.value = true;
    }

    void onResolutionGoalSelected(String selected) {
      resolutionGoal.value = selected;
    }

    useEffect(() {
      isSubmitted.value = false;
      userInput.value = '';
      print('>>>>>>>>>>>>>>>>>>>object');
      ConfirmPostRemoteDatasourceImpl().getAllConfirmPosts();

      return null;
    }, []);

    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 200,
            color: Colors.grey,
            child: Column(
              children: [
                /// Active Goal Dropdown
                ActiveGoalDropdown(
                  isSubmitted: isSubmitted,
                  onResolutionGoalSelected: onResolutionGoalSelected,
                ),

                /// Confirm Post Forms
                ConfirmPostForm(
                  isSubmitted: isSubmitted,
                  onUserInput: onUserInput,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
