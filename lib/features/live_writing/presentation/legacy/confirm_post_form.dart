import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wehavit/features/live_writing/data/data.dart';
import 'package:wehavit/features/live_writing/domain/repositories/live_writing_mine_repository_provider.dart';
import 'package:wehavit/features/live_writing/presentation/legacy/confirm_post_content_input.dart';
import 'package:wehavit/features/live_writing/presentation/legacy/confirm_post_title_input.dart';

class ConfirmPostForm extends HookConsumerWidget {
  ConfirmPostForm({
    super.key,
    required this.isSubmitted,
    required this.onSubmit,
  });

  final ValueNotifier<bool> isSubmitted;
  final Function(String, String) onSubmit;
  final _confirmPostFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var titleController = useTextEditingController();
    var contentController = useTextEditingController();

    useEffect(
      () {
        titleController.addListener(() async {
          ref
              .read(liveWritingPostRepositoryProvider)
              .updateTitle(titleController.text);
        });
        contentController.addListener(() async {
          ref
              .read(liveWritingPostRepositoryProvider)
              .updateMessage(contentController.text);
        });

        return null;
      },
      [],
    );

    Future<void> onSave() async {
      //getAllFanMarkedConfirmPosts();
      ref.read(confirmPostDatasourceProvider).getAllFanMarkedConfirmPosts();
      if (isSubmitted.value) {
        return;
      }

      if (_confirmPostFormKey.currentState!.validate()) {
        _confirmPostFormKey.currentState!.save();
        onSubmit(titleController.text, contentController.text);
        isSubmitted.value = true;
      }
    }

    return Expanded(
      child: Form(
        key: _confirmPostFormKey,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: ConfirmPostTitleTextFormField(
                  isSubmitted: isSubmitted,
                  titleController: titleController,
                  titleValidator: (value) =>
                      (value ?? '').isEmpty ? '제목을 입력해주세요' : null,
                ),
              ),

              /// Confirm Post Content
              Expanded(
                flex: 3,
                child: ConfirmPostContentTextFormField(
                  isSubmitted: isSubmitted,
                  contentController: contentController,
                  contentValidator: (value) =>
                      (value ?? '').isEmpty ? '내용을 입력해주세요' : null,
                ),
              ),
              // Confirm Post Button
              ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  maximumSize: const Size(65, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '완료',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
