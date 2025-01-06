import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/common/constants/constants.dart';
import 'package:wehavit/presentation/common_components/wh_icon.dart';

class WideColoredButton extends StatelessWidget {
  const WideColoredButton({
    super.key,
    this.backgroundColor = CustomColors.whYellow500,
    this.foregroundColor = CustomColors.whGrey800,
    required this.buttonTitle,
    required this.onPressed,
    this.iconString = '',
    this.isDiminished = false,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final String buttonTitle;
  final String iconString;
  final Function onPressed;
  final bool isDiminished;

  @override
  Widget build(BuildContext context) {
    if (isDiminished) {
      return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          backgroundColor: CustomColors.whGrey,
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
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shadowColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 58,
          child: iconString.isEmpty
              ? Text(
                  buttonTitle,
                  style: context.bodyLarge?.bold.copyWith(color: foregroundColor),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      buttonTitle,
                      style: context.bodyLarge?.bold,
                    ),
                    const SizedBox(width: 8),
                    WHIcon(
                      size: WHIconsize.medium,
                      iconString: iconString,
                      iconColor: foregroundColor,
                    ),
                  ],
                ),
        ),
      );
    }
  }
}
