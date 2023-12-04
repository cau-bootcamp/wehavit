import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wehavit/features/live_writing/presentation/legacy/confirm_post_form.dart';
import 'package:wehavit/features/live_writing/presentation/legacy/user_active_goal_dropdown.dart';

// TODO. 이 파일을 수정하여 내가 실시간 글쓰기를 하는 위젯을 완성하면 됩니다.
class MyLiveWriting extends HookConsumerWidget {
  const MyLiveWriting({
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
  Widget build(BuildContext context, WidgetRef ref) {
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
