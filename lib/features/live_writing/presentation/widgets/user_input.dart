import 'package:flutter/material.dart';

class ConfirmPostContentTextField extends StatelessWidget {
  const ConfirmPostContentTextField({
    required this.isSubmitted,
    required this.onSubmitted,
    super.key,
  });

  final bool isSubmitted;
  final Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    if (!isSubmitted) {
      return _getInputFields(onSubmitted);
    }

    return const Placeholder();
  }

  Widget _getInputFields(Function(String) onSubmitted) {
    return TextField(
      minLines: 5,
      maxLines: 5,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: ' 오늘의 인증글을 남겨주세요!',
        filled: true,
      ),
      onSubmitted: onSubmitted,
    );
  }
}

class ConfirmPostTitleTextField extends StatelessWidget {
  const ConfirmPostTitleTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TextField(
      minLines: 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: '인증 글쓰기',
      ),
    );
  }
}
