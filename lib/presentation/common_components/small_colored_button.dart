import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';

class SmallColoredButton extends StatelessWidget {
  const SmallColoredButton({
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
      child: TextButton(
        onPressed: () {
          if (isDisabled == false) onPressed();
        },
        style: TextButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.zero,
          shadowColor: Colors.transparent,
          backgroundColor: isDisabled ? CustomColors.whGrey600 : backgroundColor,
          minimumSize: Size.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
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
