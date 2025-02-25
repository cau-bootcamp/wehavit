import 'dart:async';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/common/constants/constants.dart';
import 'package:wehavit/presentation/presentation.dart';

class SearchFormField extends StatefulWidget {
  const SearchFormField({
    required this.textEditingController,
    this.placeholder = '',
    this.type = TextInputType.text,
    this.maxLength = 100,
    super.key,
  });

  final TextEditingController textEditingController;
  final String placeholder;
  final TextInputType type;
  final int maxLength;

  @override
  // ignore: no_logic_in_create_state
  State<SearchFormField> createState() => _SearchFormFieldState(
        textEditingController,
        placeholder,
        type,
      );
}

class _SearchFormFieldState extends State<SearchFormField> {
  _SearchFormFieldState(
    this.controller,
    this.placeholder,
    this.type,
  );

  final TextEditingController controller;
  final String placeholder;
  final TextInputType type;
  Timer? _debounce;

  void onChanged(String newString) {
    // 변경사항에 대해 0.5초의 delay를 주고 반영함. controller에도 즉각적으로 변경사항이 반영되지 않는다.
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      controller.text = newString;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorColor: CustomColors.whWhite,
          maxLength: widget.maxLength,
          textAlignVertical: TextAlignVertical.top,
          style: context.bodyMedium?.copyWith(color: CustomColors.whGrey900),
          decoration: InputDecoration(
            prefixIconConstraints: const BoxConstraints.tightFor(height: 28),
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 12.0, right: 12.0),
              child: IntrinsicHeight(
                child: WHIcon(size: WHIconsize.medium, iconString: WHIcons.search),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            hintStyle: context.bodyMedium?.copyWith(color: CustomColors.whGrey700),
            hintText: placeholder,
            errorStyle: context.labelMedium?.copyWith(color: CustomColors.whRed500),
            counterText: '',
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
          textInputAction: TextInputAction.search,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
