import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/common/constants/constants.dart';

class InputFormField extends StatefulWidget {
  const InputFormField({
    required this.textEditingController,
    this.placeholder = '',
    this.type = TextInputType.text,
    this.isObscure = false,
    super.key,
  });

  final TextEditingController textEditingController;
  final String placeholder;
  final TextInputType type;
  final bool isObscure;

  @override
  // ignore: no_logic_in_create_state
  State<InputFormField> createState() => _InputFormFieldState(
        textEditingController,
        placeholder,
        type,
        isObscure,
      );
}

class _InputFormFieldState extends State<InputFormField> {
  _InputFormFieldState(
    this.controller,
    this.placeholder,
    this.type,
    this.isObscure,
  );

  final TextEditingController controller;
  final String placeholder;
  final TextInputType type;
  final bool isObscure;

  void onChanged(String newString) {
    controller.text = newString;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: CustomColors.whWhite,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
        labelStyle: context.bodyMedium?.copyWith(color: CustomColors.whGrey900),
        hintStyle: context.bodyMedium?.copyWith(color: CustomColors.whGrey700),
        hintText: placeholder,
        fillColor: CustomColors.whGrey300,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
      controller: controller,
      keyboardType: type,
      obscureText: isObscure,
      onChanged: onChanged,
    );
  }
}
