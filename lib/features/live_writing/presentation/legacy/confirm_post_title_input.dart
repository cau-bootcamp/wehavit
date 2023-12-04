import 'package:flutter/material.dart';

const titleTextFormHint = '인증 제목. (ex) 헬린이 1일차 인증!';

class ConfirmPostTitleTextFormField extends StatelessWidget {
  const ConfirmPostTitleTextFormField({
    required this.isSubmitted,
    required this.titleController,
    required this.titleValidator,
    super.key,
  });

  final ValueNotifier<bool> isSubmitted;
  final TextEditingController titleController;
  final String? Function(String?) titleValidator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      style: const TextStyle(
        fontSize: 10,
      ),
      decoration: const InputDecoration(
        hintText: titleTextFormHint,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(0),
          ),
        ),
      ),
      validator: titleValidator,
      controller: titleController,
      readOnly: isSubmitted.value,
    );
  }
}
