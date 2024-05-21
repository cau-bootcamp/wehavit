import 'package:flutter/material.dart';
import 'package:wehavit/common/constants/constants.dart';

class WideColoredButton extends StatelessWidget {
  const WideColoredButton({
    super.key,
    this.backgroundColor,
    this.foregroundColor = CustomColors.whWhite,
    required this.buttonTitle,
    this.buttonIcon,
    this.onPressed,
    this.isDiminished = false,
  });

  final Color? backgroundColor;
  final Color foregroundColor;
  final String buttonTitle;
  final IconData? buttonIcon;
  final Function? onPressed;
  final bool isDiminished;

  @override
  Widget build(BuildContext context) {
    if (isDiminished) {
      return ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 58,
          child: Text(
            buttonTitle,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: CustomColors.whPlaceholderGrey,
            ),
          ),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.transparent,
          foregroundColor: foregroundColor,
          shadowColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          side: BorderSide(
            color: backgroundColor != null ? backgroundColor! : foregroundColor,
            width: 2,
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 58,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonTitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Visibility(
                visible: buttonIcon != null,
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    Icon(
                      buttonIcon,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
