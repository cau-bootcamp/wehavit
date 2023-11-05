import 'package:flutter/material.dart';

const contentTextFormHint = '오늘의 인증 글을 남겨주세요!';

class ConfirmPostContentTextFormField extends StatelessWidget {
  const ConfirmPostContentTextFormField({
    required this.isSubmitted,
    required this.contentController,
    required this.contentValidator,
    super.key,
  });

  final ValueNotifier<bool> isSubmitted;
  final TextEditingController contentController;
  final String? Function(String?) contentValidator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 3,
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      style: const TextStyle(
        fontSize: 10,
      ),
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(0),
          ),
        ),
        hintText: contentTextFormHint,
        filled: true,
      ),
      validator: contentValidator,
      controller: contentController,
      readOnly: isSubmitted.value,
    );
  }
}
