import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wehavit/features/live_writing/presentation/widgets/user_input.dart';

class ConfirmPostForm extends HookConsumerWidget {
  ConfirmPostForm({
    super.key,
    required this.isSubmitted,
    required this.onUserInput,
  });

  final ValueNotifier<bool> isSubmitted;
  final Function(String) onUserInput;
  final _confirmPostFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final titleTextController =
    //     useTextEditingController(text: confirmModel.title ?? '');

    return Expanded(
      child: Container(
        color: Colors.blueGrey,
        width: double.infinity,
        height: 100,
        child: Column(
          children: [
            ConfirmPostTitleTextField(),

            /// Confirm Post Content
            Expanded(
              child: ConfirmPostContentTextField(
                /**/
                isSubmitted: isSubmitted.value,
                onSubmitted: onUserInput,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
