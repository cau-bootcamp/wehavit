import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';

class SmallColoredButtonWidget extends StatelessWidget {
  const SmallColoredButtonWidget({
    super.key,
    required this.buttonLabel,
    this.backgroundColor = CustomColors.whYellow,
    this.foregroundColor = CustomColors.whBlack,
    required this.onPressed,
  });

  final String buttonLabel;
  final Color backgroundColor;
  final Color foregroundColor;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0.0),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shadowColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
        ),
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
          }
        },
        child: Container(
          height: 30,
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          alignment: Alignment.center,
          child: Text(
            buttonLabel,
            style: const TextStyle(
              color: CustomColors.whDarkBlack,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
