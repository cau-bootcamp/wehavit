import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';

class SmallColoredButtonWidget extends StatelessWidget {
  const SmallColoredButtonWidget({
    super.key,
    required this.buttonLabel,
    this.backgroundColor = CustomColors.whYellow,
    this.foregroundColor = CustomColors.whGrey200,
    required this.onPressed,
    this.isDisabled = false,
  });

  final String buttonLabel;
  final Color backgroundColor;
  final Color foregroundColor;
  final Function onPressed;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0.0),
          backgroundColor: isDisabled ? CustomColors.whGrey600 : backgroundColor,
          foregroundColor: foregroundColor,
          shadowColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
        ),
        onPressed: () {
          if (isDisabled != false) onPressed();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 6.0,
          ),
          alignment: Alignment.center,
          child: Text(
            buttonLabel,
            style: context.labelMedium?.bold.copyWith(color: foregroundColor),
          ),
        ),
      ),
    );
  }
}
