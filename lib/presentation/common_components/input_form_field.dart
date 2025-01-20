import 'dart:async';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:wehavit/common/constants/constants.dart';

class InputFormField extends StatefulWidget {
  const InputFormField({
    required this.textEditingController,
    this.focusNode,
    this.placeholder = '',
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.isObscure = false,
    this.maxLines = 1,
    this.maxLength = 100,
    this.descrptionHandler,
    super.key,
  });

  final TextEditingController textEditingController;
  final FocusNode? focusNode;
  final String placeholder;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final int maxLines;
  final int maxLength;
  final bool isObscure;

  /// 입력된 텍스트에 대해서 InputFormField 하단에 Description을 보여주고 싶다면
  /// descrptionHandler를 통해 입력된 특정 문자열에 대해 (설명, 설명타입) 의 형식으로 반환하는 메서드를 전달합니다.
  final (String, FormFieldDescriptionType)? Function(String)? descrptionHandler;

  @override
  // ignore: no_logic_in_create_state
  State<InputFormField> createState() => _InputFormFieldState(
        textEditingController,
        focusNode,
        placeholder,
        textInputType,
        textInputAction,
        isObscure,
        descrptionHandler,
      );
}

class _InputFormFieldState extends State<InputFormField> {
  _InputFormFieldState(
    this.controller,
    this.focusNode,
    this.placeholder,
    this.textInputType,
    this.textInputAction,
    this.isObscure,
    this.descrptionHandler,
  );

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String placeholder;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool isObscure;
  final (String, FormFieldDescriptionType)? Function(String)? descrptionHandler;
  Timer? _debounce;

  String _descriptionLabel = '';
  FormFieldDescriptionType _descriptionType = FormFieldDescriptionType.none;

  void onChanged(String newString) {
    // 변경사항에 대해 0.5초의 delay를 주고 반영함. controller에도 즉각적으로 변경사항이 반영되지 않는다.
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      controller.text = newString;

      _updateDescription(newString);
    });
  }

  @override
  void initState() {
    super.initState();

    // 초기값에 대한 description handler 적용
    _updateDescription(controller.text);
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
          focusNode: focusNode,
          cursorColor: CustomColors.whWhite,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          textAlignVertical: TextAlignVertical.top,
          style: context.bodyMedium?.copyWith(color: CustomColors.whGrey900),
          decoration: InputDecoration(
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
          keyboardType: textInputType,
          textInputAction: textInputAction,
          obscureText: isObscure,
          onChanged: onChanged,
        ),
        AnimatedSize(
          duration: 100.ms,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: FormFieldDescription(
                    type: _descriptionType,
                    label: _descriptionLabel,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // description handler를 적용하는 메서드
  // descrptionHandler가 null이 아닌 경우, 입력된 텍스트에 대해 validator를 실행하여 결과에 따라 Description 위젯을 그리기
  void _updateDescription(String text) {
    if (descrptionHandler != null) {
      final validateResult = descrptionHandler!(text);

      setState(() {
        _descriptionLabel = validateResult?.$1 ?? '';
        _descriptionType = validateResult?.$2 ?? FormFieldDescriptionType.none;
      });
    }
  }
}

enum FormFieldDescriptionType {
  none,
  normal,
  warning,
  clear;
}

class FormFieldDescription extends StatelessWidget {
  const FormFieldDescription({
    this.type = FormFieldDescriptionType.normal,
    this.label = '',
    super.key,
  });

  final FormFieldDescriptionType type;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textStyle = switch (type) {
      FormFieldDescriptionType.none => null,
      FormFieldDescriptionType.normal => context.labelMedium?.copyWith(color: CustomColors.whGrey700),
      FormFieldDescriptionType.warning => context.labelMedium?.copyWith(color: CustomColors.whRed500),
      FormFieldDescriptionType.clear => context.labelMedium?.copyWith(color: CustomColors.pointGreen),
    };

    switch (type) {
      // Type이 .none인 경우에는 DescriptionLabel을 보여주지 않음
      case FormFieldDescriptionType.none:
        return Container();
      // Type이 유효한 경우에는 DescriptionLabel을 스타일을 적용해 보여줌
      default:
        return Text(
          label,
          style: textStyle,
          textAlign: TextAlign.start,
          maxLines: 1,
        );
    }
  }
}
