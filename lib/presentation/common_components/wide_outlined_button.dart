import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/common/constants/constants.dart';
import 'package:wehavit/presentation/common_components/wh_icon.dart';

class WideOutlinedButton extends StatelessWidget {
  const WideOutlinedButton({
    super.key,
    this.foregroundColor = CustomColors.whGrey800,
    required this.buttonTitle,
    required this.onPressed,
    this.buttonIcon,
    this.isDiminished = false,
  });

  final Color foregroundColor;
  final String buttonTitle;
  final IconData? buttonIcon;
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
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          side: const BorderSide(
            color: CustomColors.whGrey500,
            width: 2,
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 58,
          child: Text(
            buttonTitle,
            style: context.bodyLarge?.bold.copyWith(
              color: CustomColors.whGrey500,
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
          backgroundColor: Colors.transparent,
          foregroundColor: foregroundColor,
          shadowColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          side: BorderSide(
            color: foregroundColor,
            width: 2,
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 58,
          child: buttonIcon == null
              ? Text(
                  buttonTitle,
                  style: context.bodyLarge?.bold.copyWith(color: foregroundColor),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      buttonTitle,
                      style: context.bodyLarge?.bold.copyWith(color: foregroundColor),
                    ),
                    const SizedBox(width: 8),
                    WHIcon(
                      size: WHIconsize.medium,
                      iconData: buttonIcon!,
                      iconColor: foregroundColor,
                    ),
                  ],
                ),
        ),
      );
    }
  }
}
